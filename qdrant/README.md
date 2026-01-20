# Qdrant Vector Database

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-qdrant)


## What is Qdrant?

Qdrant is a high-performance vector similarity search engine and database. It's designed for machine learning applications requiring efficient vector search capabilities, including:
- Semantic search
- Recommendation systems
- Neural network applications
- Image/video similarity search
- Embeddings storage and retrieval

## Accessing Qdrant

Once deployed, you'll receive a URI in the format:
- HTTP API: `http://<random-subdomain>.provider.akash.network`
- gRPC: `<random-subdomain>.provider.akash.network:6334`

### Health Check

```bash
curl http://<your-uri>/
```

### Web UI

Access the Qdrant dashboard at:
```
http://<your-uri>/dashboard
```

## Configuration Customization

### Adjust Resources

Edit the `profiles.compute.qdrant.resources` section:

```yaml
resources:
  cpu:
    units: 4  # Increase for better performance
  memory:
    size: 8Gi  # Increase for larger datasets
  storage:
    - size: 10Gi
    - name: data
      size: 100Gi  # Increase for more vector data
```

## Resources

- [Qdrant Documentation](https://qdrant.tech/documentation/)
- [Akash Documentation](https://docs.akash.network/)
- [Akash Discord](https://discord.gg/akash)
- [Qdrant GitHub](https://github.com/qdrant/qdrant)
