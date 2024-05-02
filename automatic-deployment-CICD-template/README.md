# Automatic Deployment Tool for JavaScript Applications on Akash Network

This is an MVP of our new product, designed to streamline JavaScript deployments on the Akash Network by creating a Vercel-like pipeline. This tool automates the deployment process directly from your public repository, ensuring your applications are up-to-date with the latest changes pushed to your repo. It supports a variety of JavaScript frameworks and eliminates the need to containerize applications manually.


## Supported Frameworks

This tool is currently compatible with:
1. React
2. React + Vite
3. Astro.js
4. Vue.js

## Key Features

- **Automatic Builds and Deployments**: Set your project to automatically build and deploy using just the URL of your public repository.
- **Continuous Updates**: Changes pushed to your repository are automatically fetched and deployed, ensuring your application is always current without any manual intervention.
- **Configuration Flexibility**: Optionally specify a build directory and custom build commands to tailor the deployment process to your project's needs.

## Getting Started

Follow these simple steps to use this tool:

1. **Set Environment Variables**: Replace `REPO_URL` in the environment variables section of the SDL file with your public repository URL.
2. **Customize Build Settings** (Optional): Add `BUILD_DIRECTORY` and `BUILD_COMMAND` as environment variables, similar to `REPO_URL`, if you need to customize the build process. Do this only if they differ from standard conventions like dist or build etc.
3. **Deploy**: Use the SDL file to deploy your application. The tool handles the rest, from building to running your application.


**NOTE**: This is still a work in progress and not built for production, this might fail for some repos.
This tool is under continuous development, with future updates aimed at enhancing functionality and user experience. Stay tuned!