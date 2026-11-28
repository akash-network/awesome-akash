# Console SDL lint

Akash Console (`console.akash.network` / `air.akash.network`) validates templates in the SDL editor with **monaco-yaml** and `validationSDLSchema` from [`@akashnetwork/chain-sdk`](https://github.com/akash-network/chain-sdk) (`go/sdl/sdl-input.schema.yaml`).

The TypeScript `Sdl = z.infer<typeof sdlSchema>` in Console’s API is only the **hardware summary** (cpu / memory / storage). Editor red squiggles (“syntax error”) are this JSON Schema: `additionalProperties: false` on each service, expose item, compute profile, and so on.

Docker Compose `depends_on: [other]` is **not** in that schema. Console expects:

```yaml
dependencies:
  - service: other
```

## Run

From the repository root (Node 18+; first run installs `ajv` / `yaml` under `scripts/sdl-console-lint/`):

```bash
node scripts/sdl-console-lint.mjs --all
node scripts/sdl-console-lint.mjs path/to/deploy.yaml
node scripts/sdl-console-lint.mjs --fix path/to/deploy.yaml
```

`--fix` rewrites `depends_on` to `dependencies` and keeps surrounding comments when the YAML parser can.

Vendored schema: `scripts/vendor/sdl-input.schema.yaml` (refresh from chain-sdk `main` when Console updates).
