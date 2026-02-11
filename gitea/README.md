# What is Gitea?

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-gitea)

Gitea is a painless, self-hosted, all-in-one software development service. It includes Git hosting, code review, team collaboration, package registry, and CI/CD. It is similar to GitHub, Bitbucket and GitLab.

## Deploy on Akash
1. Go to [Akash Console](https://console.akash.network/).
2. Deploy SDL from this repository: [deploy.yaml](deploy.yaml) for standart deployment with SQLite3 database or [deploy_postgres.yaml](deploy_postgres.yaml) for deployment with Postgres database as second service.
3. Open URI from Leases tab with forwarded port 3000 to access Gitea.
---
For more information, please see the [Gitea documentation](https://docs.gitea.com/installation/install-with-docker-rootless).
