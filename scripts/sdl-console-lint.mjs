#!/usr/bin/env node
/**
 * Lint (and optionally rewrite) Akash SDL YAML against the same JSON Schema
 * Console uses in the SDL editor:
 *
 *   monaco-yaml + validationSDLSchema from @akashnetwork/chain-sdk
 *   source: go/sdl/sdl-input.schema.yaml
 *
 * Console type:  Sdl = z.infer<typeof sdlSchema>  is only the hardware
 * summary (cpu/memory/storage). Rejection of unknown keys (e.g. Docker-style
 * `depends_on`) comes from this JSON Schema (`additionalProperties: false`
 * on each service).
 *
 * Usage (from repo root):
 *   node scripts/sdl-console-lint.mjs [files...]
 *   node scripts/sdl-console-lint.mjs --fix path/to/deploy.yaml
 *   node scripts/sdl-console-lint.mjs --all
 *
 * --fix rewrites Docker Compose `depends_on: [svc]` to Console
 * `dependencies: [{ service: svc }]`, then re-validates.
 */
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, "..");
const schemaPath = path.join(here, "vendor", "sdl-input.schema.yaml");
const pkgDir = path.join(here, "sdl-console-lint");

function ensureDeps() {
  const marker = path.join(pkgDir, "node_modules", "ajv", "package.json");
  if (fs.existsSync(marker)) return;
  const r = spawnSync("npm", ["install", "--omit=dev"], {
    cwd: pkgDir,
    stdio: "inherit",
  });
  if (r.status !== 0) {
    console.error("npm install failed in scripts/sdl-console-lint");
    process.exit(1);
  }
}

ensureDeps();

import { createRequire } from "node:module";
const require = createRequire(path.join(pkgDir, "package.json"));
const Ajv = require("ajv");
const yamlJs = require("js-yaml");
const YAML = require("yaml");

const schema = yamlJs.load(fs.readFileSync(schemaPath, "utf8"));
const ajv = new Ajv({ allErrors: true, strict: false, validateSchema: false });
const validateSchema = ajv.compile(schema);

const args = process.argv.slice(2);
const fix = args.includes("--fix");
const all = args.includes("--all");
const files = args.filter((a) => !a.startsWith("--"));

function listDeployYamls() {
  const out = [];
  for (const ent of fs.readdirSync(root, { withFileTypes: true })) {
    if (!ent.isDirectory() || ent.name.startsWith(".")) continue;
    for (const name of ["deploy.yaml", "deploy.yml"]) {
      const p = path.join(root, ent.name, name);
      if (fs.existsSync(p)) out.push(p);
    }
  }
  return out.sort();
}

if (!all && files.length === 0) {
  console.error("Usage: node scripts/sdl-console-lint.mjs [--fix] [--all] [deploy.yaml ...]");
  process.exit(2);
}
const targets = all ? listDeployYamls() : files.map((f) => path.resolve(f));

function rewriteDependsOn(text) {
  const doc = YAML.parseDocument(text, { keepSourceTokens: true });
  const services = doc.get("services");
  if (!services || typeof services.get !== "function") return { text, changed: false };
  let changed = false;
  for (const pair of services.items ?? []) {
    const svc = pair.value;
    if (!svc || typeof svc.get !== "function") continue;
    if (!svc.has("depends_on")) continue;
    const raw = svc.get("depends_on");
    const names = [];
    if (raw && typeof raw.toJSON === "function") {
      const v = raw.toJSON();
      if (Array.isArray(v)) names.push(...v.map(String));
      else if (v && typeof v === "object") names.push(...Object.keys(v));
      else if (v != null) names.push(String(v));
    } else if (Array.isArray(raw)) {
      names.push(...raw.map(String));
    } else if (typeof raw === "string") {
      names.push(raw);
    }
    const existing = svc.get("dependencies");
    const deps = [];
    if (existing && typeof existing.toJSON === "function") {
      const ev = existing.toJSON();
      if (Array.isArray(ev)) {
        for (const item of ev) {
          if (item && typeof item === "object" && item.service) deps.push(item.service);
        }
      }
    }
    for (const n of names) {
      if (n && !deps.includes(n)) deps.push(n);
    }
    svc.delete("depends_on");
    const seq = doc.createNode(deps.map((service) => ({ service })));
    svc.set("dependencies", seq);
    changed = true;
  }
  if (!changed) return { text, changed: false };
  return { text: String(doc), changed: true };
}

function extraChecks(doc, file) {
  const errors = [];
  if (!doc || typeof doc !== "object") return errors;
  const services = doc.services ?? {};
  const compute = doc.profiles?.compute ?? {};
  const placement = doc.profiles?.placement ?? {};
  const deployment = doc.deployment ?? {};

  for (const name of Object.keys(services)) {
    if (!deployment[name]) {
      errors.push(`${file}: service "${name}" is missing from deployment`);
    }
  }
  for (const [svc, places] of Object.entries(deployment)) {
    for (const [placeName, spec] of Object.entries(places ?? {})) {
      const profile = spec?.profile;
      if (profile && !compute[profile]) {
        errors.push(`${file}: deployment ${svc}/${placeName} profile "${profile}" is not in profiles.compute`);
      }
      if (profile && placeName && placement[placeName] && !placement[placeName].pricing?.[profile]) {
        errors.push(`${file}: placement "${placeName}" has no pricing for profile "${profile}"`);
      }
      const storages = [].concat(compute[profile]?.resources?.storage ?? []);
      for (const vol of storages) {
        const persistent = vol?.attributes?.persistent === true || vol?.attributes?.persistent === "true";
        if (persistent && vol?.name) {
          const mount = services[svc]?.params?.storage?.[vol.name]?.mount;
          if (!mount) {
            errors.push(
              `${file}: persistent volume "${vol.name}" on ${svc} needs services.${svc}.params.storage.${vol.name}.mount`
            );
          }
        }
      }
    }
  }
  return errors;
}

let failed = 0;
for (const file of targets) {
  if (!fs.existsSync(file)) {
    console.error("missing", file);
    failed++;
    continue;
  }
  let text = fs.readFileSync(file, "utf8");
  if (fix) {
    const r = rewriteDependsOn(text);
    if (r.changed) {
      fs.writeFileSync(file, r.text);
      text = r.text;
      console.log("rewrote depends_on -> dependencies:", path.relative(root, file));
    }
  }
  let doc;
  try {
    doc = yamlJs.load(text);
  } catch (e) {
    console.error("YAML parse error", path.relative(root, file), e.message);
    failed++;
    continue;
  }
  const ok = validateSchema(doc);
  const extras = extraChecks(doc, path.relative(root, file));
  if (!ok) {
    failed++;
    console.error("schema", path.relative(root, file));
    for (const e of validateSchema.errors) {
      const loc = e.instancePath || "/";
      const extra = e.params?.additionalProperty ? ` (${e.params.additionalProperty})` : "";
      console.error(`  ${loc} ${e.message}${extra}`);
    }
  }
  if (extras.length) {
    failed++;
    for (const e of extras) console.error("check", e);
  }
  if (ok && extras.length === 0) {
    console.log("ok", path.relative(root, file));
  }
}

if (failed) {
  console.error(`\n${failed} file(s) failed Console SDL schema (monaco-yaml / validationSDLSchema).`);
  console.error("Fix unknown keys (depends_on -> dependencies: [{ service: name }]) or re-run with --fix.");
  process.exit(1);
}
