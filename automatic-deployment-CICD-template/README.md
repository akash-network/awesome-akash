# Console-CI/CD for JS/TS

**Quick Start**: Access this feature directly at:
https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-automatic-deployment-CICD-template&gitProvider=github

## Overview

A deployment automation tool for Akash Network that provides a Vercel-like experience. This tool streamlines the deployment process by automating builds and deployments directly from your GitHub repository.

## Supported Frameworks

### JavaScript Frameworks:
- React
- Vite-react
- Vue.js
- Astro
- Angular
- Express.js
- Next.js
- Ember.js
- Gatsby.js
- Vite
- VitePress
- Nuxt.js
- Preact
- Ionic React
- Ionic Angular
- Stencil
- Gridsome
- Umi.js
- 11ty.js
- Remix
- VuePress

## Key Features

- **Automated Builds and Deployments**: Automatic build and deployment cycles triggered by GitHub commits
- **Continuous Integration**: Ensures deployed applications stay synchronized with repository changes
- **Customizable Build Processes**: Configurable build directories and commands
- **Automatic Rollback**: Reverts to previous working version in case of deployment failures

## Getting Started

### 1. Configure Environment Variables
Adjust the SDL file with your project-specific variables:
- `REPO_URL`
- `BRANCH_NAME`

### 2. Customize Build Settings
Configure custom build parameters if needed:
- `BUILD_DIRECTORY`
- `BUILD_COMMAND`

### 3. Deploy
Execute deployment after SDL configuration is complete.

## Sample SDL Configuration

```yaml
---
version: "2.0"
services:
  service-1:
    image: hoomanhq/automation:0.421
    expose:
      - port: 3000
        as: 80
        to:
          - global: true
    env:
      - "REPO_URL=https://github.com/onwidget/astrowind"
      - "BRANCH_NAME=main"
profiles:
  compute:
    service-1:
      resources:
        cpu:
          units: 2
        memory:
          size: 6GB
        storage:
          - size: 10Gi
  placement:
    dcloud:
      pricing:
        service-1:
          denom: uakt
          amount: 10000
deployment:
  service-1:
    dcloud:
      profile: service-1
      count: 1
```

For the complete SDL template, visit: [Awesome Akash Repository](https://github.com/akash-network/awesome-akash/blob/master/automatic-deployment-CICD-template/deploy.yml)


## Contributing
We welcome feedback and contributions to help improve this deployment tool for the Akash Network community.

## Acknowledgments
Developed by HoomanHq for the Akash Network ecosystem.
