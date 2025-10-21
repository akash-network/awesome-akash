# Supabase on Akash

This template deploys [Supabase](https://supabase.com/), an open source Firebase alternative offering all the backend features developers need to build a product: PostgreSQL database, authentication, instant APIs, realtime subscriptions, and storage.

## Features

- PostgreSQL database
- RESTful API with PostgREST
- Authentication with GoTrue
- Realtime subscriptions
- File storage
- Supabase Studio (Web UI)

## Deployment

### Prerequisites

- Akash account with funds
- Akash CLI installed and configured

### Security Configuration (Important)

⚠️ **Before deploying:** You must edit the `deploy.yaml` file to replace the placeholder values with your own secure keys and secrets:

1. Generate a JWT secret (at least 32 characters) for these fields:
   - `PGRST_JWT_SECRET`
   - `GOTRUE_JWT_SECRET`
   - `JWT_SECRET`

   You can generate a secure random string with:
   ```bash
   openssl rand -base64 32
   ```

2. Generate JWT tokens for Supabase authentication:
   - For `SUPABASE_ANON_KEY` and `ANON_KEY`: Create an anonymous role JWT
   - For `SUPABASE_SERVICE_KEY` and `SERVICE_KEY`: Create a service role JWT
   
   **Important:** Both the anonymous and service tokens must be signed with the same `JWT_SECRET` you created in step 1.
   
   You can use the [jwt.io](https://jwt.io/) website with your JWT secret to create these tokens with the appropriate payloads.

3. Consider changing the default database credentials for production use.

### Deploying on Akash

1. Create a deployment with the provided SDL:

```bash
provider-services tx deployment create deploy.yaml --from <YOUR_KEY_NAME>
```

2. List deployments and find your deployment ID:

```bash
provider-services query deployment list --owner <YOUR_AKASH_ADDRESS>
```

3. Create a lease:

```bash
provider-services tx market lease create --dseq <DEPLOYMENT_ID> --provider <PROVIDER_ADDRESS> --from <YOUR_KEY_NAME>
```

4. Send manifest:

```bash
provider-services send-manifest deploy.yaml --dseq <DEPLOYMENT_ID> --provider <PROVIDER_ADDRESS> --from <YOUR_KEY_NAME>
```

5. Get lease status (includes your Supabase Studio URL):

```bash
provider-services lease-status --dseq <DEPLOYMENT_ID> --provider <PROVIDER_ADDRESS> --from <YOUR_KEY_NAME>
```

### Post-Deployment Configuration (Important)

After deployment, you must update the following environment variables in your `deploy.yaml` file with your actual Akash ingress URL, then redeploy:

- `PUBLIC_URL`: Set to `https://<deployment-id>.ingress.akash.network`
- `SUPABASE_PUBLIC_URL`: Set to `https://<deployment-id>.ingress.akash.network`
- `API_EXTERNAL_URL`: Set to `https://<deployment-id>.ingress.akash.network`
- `GOTRUE_SITE_URL`: Set to `https://<deployment-id>.ingress.akash.network`

Without this step, authentication and other features may not work properly.

## Access and Configuration

Once deployed, you can access the Supabase Studio at:

```
https://<deployment-id>.ingress.akash.network
```

For example, if your deployment ID is `123456`, the URL would be:
```
https://123456.ingress.akash.network
```

You'll need to use the keys you configured in the deployment YAML for authentication.

## Data Persistence

This deployment includes persistent storage for:

- PostgreSQL data at `/var/lib/postgresql/data`
- Storage API files at `/var/lib/storage`

Your data should persist across restarts as long as the lease is maintained.

## Connecting to Your Supabase Instance

Once Supabase is running, you can use the Studio web interface to:

1. Create and manage database tables
2. Set up authentication providers
3. Create API keys
4. Configure storage buckets
5. View realtime logs and more

For client applications, use the public URL and anon key to connect using the [Supabase client libraries](https://github.com/supabase/supabase-js).

## Additional Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase GitHub](https://github.com/supabase/supabase)
- [Akash Network Documentation](https://akash.network/docs/)
