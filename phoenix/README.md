# Phoenix

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-phoenix)

Phoenix is an open-source AI observability and evaluation platform for LLM applications.

## What this template deploys

This Akash SDL deploys:

- Phoenix server
- PostgreSQL for traces, evals, datasets, and experiments
- Persistent storage for Phoenix working data
- Persistent storage for PostgreSQL

Public ports:

- `6006` — Phoenix UI and OTLP HTTP collector
- `4317` — OTLP gRPC collector

Phoenix accepts OTLP HTTP traces on:

```bash
http://<akash-host>:<forwarded_port_6006>/v1/traces
```

## Before deployment

Change these placeholder values in `deploy.yaml` before deploying:

```bash
CHANGE_POSTGRES_PASSWORD
CHANGE_ADMIN_PASSWORD
```

Generate strong values, for example:

```bash
openssl rand -base64 32
```

The initial admin password is controlled by:

```bash
PHOENIX_DEFAULT_ADMIN_INITIAL_PASSWORD=CHANGE_ADMIN_PASSWORD
```

The default admin email is:

```bash
admin@localhost
```

Changing `PHOENIX_DEFAULT_ADMIN_INITIAL_PASSWORD` after the admin user has already been created will not reset the password. Update it from the Phoenix UI or redeploy with a fresh database.

## Storage

Phoenix uses PostgreSQL through:

```bash
PHOENIX_SQL_DATABASE_URL=postgresql://phoenix:CHANGE_POSTGRES_PASSWORD@db:5432/phoenix
```

PostgreSQL data is stored in a persistent volume mounted at:

```bash
/var/lib/postgresql/data
```

Phoenix working data is stored in a persistent volume mounted at:

```bash
/mnt/data
```

Default persistent storage sizes:

```bash
Phoenix working data: 20Gi
PostgreSQL data: 20Gi
```

You can increase them in the `profiles.compute` section.

## Sending traces

Use the Akash endpoint assigned to port `<forwarded_port_6006>` as the Phoenix collector endpoint.

Example OTLP HTTP endpoint:

```bash
http://<akash-host>:<forwarded_port_6006>/v1/traces
```

For OpenInference or OpenTelemetry-based clients, configure the collector endpoint to this URL.

The gRPC collector is exposed on port `<forwarded_port_4317>`:

```bash
<akash-host>:<forwarded_port_4317>
```

## Notes

This template is intended as a simple self-hosted Phoenix deployment for Akash.
For production use, consider adding your own domain, TLS termination, authentication hardening, backup policy, and retention settings.
