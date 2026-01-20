# What is Elasticsearch?

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-elasticsearch)

[Elasticsearch](https://github.com/elastic/elasticsearch) is a distributed search and analytics engine, scalable data store, and vector database built on Apache Lucene.

# What is Kibana?
[Kibana](https://github.com/elastic/kibana) is a source-available data visualization dashboard software for Elasticsearch.

## Deploy on Akash
Deploy Elasticsearch with SDL file from this repository. Use [deploy.yaml](deploy.yaml) for default deployment or [deploy_with_kibana.yaml](deploy_with_kibana.yaml) for deployment with Kibana.

## REST APIs
Check the status of your deployment using [REST API](https://www.elastic.co/docs/reference/elasticsearch/rest-apis) requests. For example:
```
localhost:9200/_cat/health
```
Where `localhost:9200` is the URI of your deployment.
