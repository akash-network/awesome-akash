# Neo4j on Akash Network

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-neo4j)


This guide helps you deploy a Neo4j graph database on the Akash decentralized cloud network with persistent storage.

## Overview

Neo4j is a powerful graph database that stores data as nodes and relationships. This deployment provides:

- Neo4j 5.15.0 (latest stable version)
- Browser interface (port 7474)
- Bolt protocol access (port 7687)
- Persistent storage for data and logs
- Optimized memory configuration

## Configuration

### 1. Update Security Settings

**Critical:** Change the default password in `deploy.yaml`:

```yaml
- NEO4J_AUTH=neo4j/your-secure-password-here
```

Replace `your-secure-password-here` with a strong password.

### 2. Adjust Resources (Optional)

Modify the compute resources based on your needs:

```yaml
cpu:
  units: 2           # CPU cores
memory:
  size: 4Gi          # RAM
storage:
  - size: 10Gi       # Database storage
  - size: 5Gi        # Logs storage
```

### 3. Update Pricing

Check current Akash market rates and adjust the bid price:

```yaml
pricing:
  neo4j:
    denom: uakt
    amount: 1000     # Adjust based on current market rates
```

## Accessing Neo4j

### Browser Interface

Once deployed, access the Neo4j Browser at:

```
http://<provider-uri>:7474
```

Login with:
- **Username:** neo4j
- **Password:** (the password you set in deploy.yaml)

### Bolt Connection

Connect your applications using the Bolt protocol:

```
bolt://<provider-uri>:7687
```

## Persistent Storage

This deployment uses Akash's persistent storage feature:

- **Data Volume:** 10 GB mounted at `/data` (database files)
- **Logs Volume:** 5 GB mounted at `/logs` (log files)
- **Storage Class:** beta3

Your data will persist across:
- Container restarts
- Pod rescheduling
- Redeployments to the same provider

**Important:** Persistent storage requires providers with storage support enabled.

## Resources

- [Akash Documentation](https://docs.akash.network/)
- [Neo4j Documentation](https://neo4j.com/docs/)
- [Akash Discord](https://discord.akash.network/)
- [Neo4j Community](https://community.neo4j.com/)
