# Introducing a Revolutionary Deployment Tool on the Akash Network to Deploy Applications Directly from GitHub/GitLab/BitBucket

If you’ve ever found yourself bogged down by the complexities of deployment and CI/CD, especially on Akash Network, our new tool is here to change the game. Designed to provide a Vercel-like experience, this tool automates the deployment process, allowing you to focus on what you do best—coding!

Note: This tool is currently in the MVP phase.

## Watch the Video

[![Watch the video](https://img.youtube.com/vi/bzPXWKgyEtw/maxresdefault.jpg)](https://youtu.be/bzPXWKgyEtw)

## Empowering Developers with Automation

Deploying applications can often involve a steep learning curve, particularly when dealing with containerization and CI/CD pipelines. Our tool simplifies this by automating deployments directly from your GitHub repository to the Akash Network. It supports several popular JavaScript frameworks, making it a versatile option for many developers.

### Supported Frameworks Include:

#### JavaScript Frameworks:

- **React**
- **Vite-react**
- **Vue.js**
- **Astro**
- **Angular**
- **Express.js**
- **Next.js**
- **Ember.js**
- **Gatsby.js**
- **Vite**
- **VitePress**
- **Nuxt.js**
- **Preact**
- **Ionic React**
- **Ionic Angular**
- **Stencil**
- **Gridsome**
- **Umi.js**
- **11ty.js**
- **Remix**
- **VuePress**

#### Python Frameworks:

- **Django**
- **Flask**

## Key Features That Set Our Tool Apart

This deployment tool isn't just about automating processes; it's about enhancing your workflow and productivity. Here’s what it offers:

- **Automated Builds and Deployments**: Simply link your public GitHub repository, and the tool takes care of the rest. Each commit you push triggers a build and deployment cycle, ensuring your application is always up-to-date.
  
- **Continuous Integration**: Never worry about out-of-sync versions or manual updates again. This tool ensures that your deployed application mirrors the latest changes in your repository.
  
- **Customizable Build Processes**: Tailor the deployment process to fit your project's specific needs. Whether it’s specifying a custom build directory or custom commands, you have the flexibility to configure as needed.

- **Roll back to previous good version in case of bad commits**: Incase of commits that break your application and cause error, the tool will automatically roll back to previous good version.

## Getting Started: Simple Steps for Deployment

To leverage this tool effectively, follow these straightforward steps:

1. **Configure Environment Variables**: Adjust the SDL (Service Deployment Language) file to include your project specifics. Key environment variables like `REPO_URL` and `BRANCH_NAME` need to be set to align with your repository details.

2. **Customize the Build Settings**: For projects that don’t fit the conventional build paths or commands, you can easily add custom configurations like `BUILD_DIRECTORY` and `BUILD_COMMAND`.

3. **Deploy Your Application**: With your SDL file configured, deploying your application is as simple as executing the deployment command. The system handles everything from compiling to hosting.

## Sample SDL Configuration for Quick Setup

For a practical application, here’s how you might set up your SDL file:

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

This setup details how to expose your service, manage environment variables, and define resource allocations, providing a seamless deployment experience.
Awesome akash repo: [Click Here](https://github.com/akash-network/awesome-akash/blob/master/automatic-deployment-CICD-template/deploy.yml)


## Why This Tool Is a Game Changer

Our deployment tool is more than just a utility—it's a shift towards more efficient, less cumbersome development practices. By streamlining the traditional barriers associated with deployment on Akash Network, it allows you to deploy applications with the ease and agility that modern web development demands.

## What’s Next?

As we look to the future, we are excited to expand the capabilities of this tool. Our roadmap includes:

- **Support for More Languages and Frameworks**: Plans are underway to include support for additional programming languages like Python and Go, broadening the scope of our tool to cater to a more diverse range of projects.

- **Development of a User Interface**: To deliver a truly Vercel-like experience, we are in the process of creating a user-friendly interface. This will make the tool even more accessible and easier to use for all developers.

- **Email Notifications**: We will be introducing email notifications to keep you updated on the status of your deployments and other important events, enhancing the overall user experience.

- **Direct Implementation on Console**: To deliver a truly Vercel-like experience, we will be building user-friendly GUI directly onto console. This will make the tool even more accessible and easier to use for all developers.

As we continue to enhance this tool, we invite you to join us on this journey. Try it out, give us your feedback, and help us redefine the deployment landscape on the Akash Network. Happy coding and deploying!

Thank you
HoomanHq
