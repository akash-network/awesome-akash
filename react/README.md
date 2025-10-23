
# React Deployment Template on Akash

This repository provides a template to deploy a **React** application on the Akash Network. 
React is a popular JavaScript library for building dynamic user interfaces. Follow the steps below to get started.


## Table of Contents

- [Requirements](#requirements)  
- [Files Overview](#files-overview)  
- [Deploying the Application](#deploying-the-application)  
- [Additional Resources](#additional-resources)

---

## Requirements

- Node.js and npm installed (for building your React app)
- Akash CLI or Akash Console configured with an account that has sufficient funds
- **Docker Image:** You need a production-ready React app bundled into a Docker image, hosted on a public registry (like Docker Hub). The `deploy.yaml` includes a sample image — update it with your own.

---

## Files Overview

- **deploy.yaml**: Main SDL file for deploying the React app on Akash (exposes port 80, sets resource limits, etc.)
- **README.md**: This file contains setup instructions, usage, and template details.

---

## Deploying the Application


### 1. **Build and Push Your Docker Image:**
```bash
npm run build
docker build -t hxrh/quote-app:v1.0 .
docker push hxrh/quote-app:v1.0
```

### 2. **Update `deploy.yaml`:**
- Change the `image:` value under the `services:react:` section to point to your React app’s Docker image (e.g., `hxrh/quote-app:v1.0`)
- Adjust `resources:` and `pricing:` based on your app’s needs and budget

### 3. **Deploy Using Akash CLI:**
Follow the CLI setup and deployment steps provided [here](https://akash.network/docs/deployments/akash-cli/installation/)

### 4. **Or Use Akash Console:**
- Open [Akash Console](https://console.akash.network) in your browser  
- Navigate to the **Deployments** section  
- Upload your `deploy.yaml` file  
- Follow the on-screen instructions to initiate the deployment  
- Monitor your deployment status directly from the console
- To access your app the console will provide a link to your deployed application.

---

## Additional Resources

- [React Official Site](https://reactjs.org)  
- [Akash Console](https://console.akash.network)  
- [Akash CLI Installation Guide](https://akash.network/docs/deployments/akash-cli/installation/)  
- [Akash Deployment How-To](https://docs.akash.network/how-to/)
