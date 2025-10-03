
---

# Supabase on Akash

[Supabase](https://supabase.com/) is an open-source Firebase alternative built on Postgres.
This example deploys a **full Supabase stack** (Postgres, API, Auth, Realtime, Storage, and Studio) on the [Akash Network](https://akash.network).

---

## 📖 What is Supabase?

Supabase provides a backend-as-a-service with the following features:

* **Postgres Database** – scalable relational database.
* **Auth** – user authentication and authorization.
* **Realtime** – live database subscriptions.
* **Storage** – file storage and serving.
* **Studio** – an easy-to-use dashboard for managing your project.

Running on Akash allows you to host Supabase in a decentralized, cost-efficient, and censorship-resistant environment.

---

## 🚀 How to Deploy on Akash

### 1. Prerequisites

* [Install the Akash CLI](https://akash.network/docs/cli/).
* Set up your Akash wallet and publish a certificate:

  ```bash
  akash keys add <your-wallet>
  akash tx cert generate client --from <your-wallet>
  akash tx cert publish client --from <your-wallet>
  ```

### 2. Create a Deployment

* Save the provided [deploy.yaml](./deploy.yaml) SDL file.
* Submit your deployment:

  ```bash
  akash tx deployment create deploy.yaml --from <your-wallet>
  ```

### 3. Place a Bid

* Query for active bids:

  ```bash
  akash query market lease list --owner <your-wallet>
  ```
* Create a lease with a chosen provider:

  ```bash
  akash tx market lease create \
    --from <your-wallet> \
    --owner <your-wallet> \
    --dseq <deployment-id> \
    --provider <provider-address>
  ```

### 4. Access Supabase

* Get the lease details:

  ```bash
  akash provider lease-status \
    --dseq <deployment-id> \
    --from <your-wallet>
  ```
* Use the displayed URL(s) to access **Supabase Studio** and other services.

---

## ⚙️ Configuration

**Environment Variables:**

These variables can be customized inside `deploy.yaml`:

```yaml
POSTGRES_PASSWORD=your_secure_password
JWT_SECRET=your_jwt_secret
ANON_KEY=your_anon_api_key
SERVICE_ROLE_KEY=your_service_role_key
```

**Services Deployed:**

* **Postgres** → Database backend
* **Kong / API Gateway** → Routes API requests
* **Auth** → User authentication and access control
* **Realtime** → Database live queries
* **Storage** → File storage bucket
* **Studio** → Supabase dashboard

---

## 📌 Notes

* Ensure you use **strong secrets** for JWT and Postgres passwords.
* The first setup may take some minutes for Supabase services to become available.
* Backups are your responsibility — Akash storage is ephemeral. Use persistent volumes or external backups.

---

## 👥 Contributors

This example is community-contributed for Hacktoberfest.
See the [Supabase team](https://github.com/supabase) and [Akash Network](https://github.com/ovrclk) contributors for upstream projects.

---
