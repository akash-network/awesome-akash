# React on Akash Network

Deploy your React applications on the decentralized Akash Network. This template provides a basic setup for serving a production-ready React app using Nginx.

## Prerequisites

- A built React application (run `npm run build` in your React project to generate the `build` folder)

## Deployment Steps

1. **Build your React app:**
   ```bash
   npm run build
   ```

2. **Prepare your deployment:**
   - This template uses Nginx to serve static files.
   - Upload your `build` folder contents to the persistent storage at `/usr/share/nginx/html` during deployment.

3. **Deploy on Akash:**
   - Use the provided `deploy.yaml` to deploy on Akash Network.
   - Access your React app at the exposed endpoint (port 80).

## Configuration

- **Port:** 80
- **Web Server:** Nginx (Alpine)
- **Storage:** 128Mi (expand as needed for your app)

## Customization

- For larger apps, increase storage and memory in `deploy.yaml`.
- To include your build files directly, create a custom Docker image based on `nginx:alpine` and copy your build files to `/usr/share/nginx/html`.

## Resources

- [React Official Documentation](https://react.dev/)
- [Akash Deployment Guide](https://akash.network/docs/deployments/overview/)