# Gin Deployment Template on Akash

This repository provides a template to deploy a Gin (Go web framework) application on the Akash Network. Follow the steps below to get started.

## Table of Contents

- [Requirements](#requirements)
- [Files Overview](#files-overview)
- [Deploying the Application](#deploying-the-application)

## Requirements

- Go 1.12+ installed
- Akash CLI or Akash Console configured with an account that has sufficient funds
- **Docker Image:** You need a compiled Gin application bundled into a Docker image, hosted on a public registry (like Docker Hub). The `deploy.yaml` has an image.  This should be updated with the image you want to deploy.


## Files Overview

- **deploy.yaml**: Main SDL file for deploying the Gin app on Akash (exposes port 8080, sets resource limits, etc.)
- **README.md**: This file contains setup instructions, usage, and template details.

## Deploying the Application

1.  **Update `deploy.yaml`:**
    * Change the `image:` value under the `services:web:` section to point to your Gin application's Docker image.
    * (Optional) Adjust `resources:` and `pricing:` based on your application's needs and budget
2. Deploy your application using akash CLI using these steps provided [Here](https://akash.network/docs/deployments/akash-cli/installation/)
     
3. Alternatively, you can deploy and manage your application through the Akash Console:
   - Open the Akash Console in your browser.
   - Navigate to the Deployments section.
   - Upload your **deploy.yaml** file.
   - Follow the on-screen instructions to initiate the deployment.
   - Monitor your deployment status directly from the console.

## Additional Resources

- [Gin Official Site](https://gin-gonic.com/)
- [Akash Deployments Overview](https://docs.akash.network/how-to/)
