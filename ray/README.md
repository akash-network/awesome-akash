# Ray Deployment Summary

This repository contains Dockerfiles and deployment configurations for Ray clusters, specifically optimized for GPU-based workloads with Python 3.10 and CUDA 11.8 support. The provided Docker images and deployment examples facilitate the setup of Ray clusters for scalable and distributed computing. 

## Deployment Details

- `ray-nightly-py310-gpu.yml`: This deployment docker image is for the nightly main rayproject/ray:nightly-py310-gpu image with 1 head gpu and 1 worker gpu.

## Customizing Ray Container Versions

To customize the versions of CUDA, Ray, or Python used in your Ray cluster using the Dockerfile from DockerHub 
rayproject/ray:nightly-py310-gpu (`ray-nightly-py310-gpu.yml`):

Please ensure that the versions you select are compatible with each other. Incompatible versions may result in errors during the runtime of your Ray cluster. Remember the head and worker nodes must run the same version of Python and Ray. 

## Ports Details

The deployment utilizes several ports for different services. These include:

- `8265`: This port is used for the Ray dashboard and jobs endpoint.
- `6380`: This port is used for the Ray service.

## Deployment Instructions
1. Use the `deploy.yaml` file as a template to configure your Ray cluster deployment with correct docker tag.

4. Modify the `resources` section under `profiles` in the `deploy.yaml` to match the desired number of CPUs, GPUs and other resources for each node type.  Remmember that providers will sometimes have different gpu model tags in use.  This example deployment may need to be scaled down to bid on your preferred provider. 

5. Deploy the Ray cluster using the configured YAML file.  Go to https://console.akash.network/ and paste in your yaml file to deploy your cluster. 

## Environment Variables

The deployment utilizes several environment variables for configuration. These include:

- `RAY_ADDRESS`: default(`ray-head:6380`) Specifies the address of the head node.

## Modifying Deployment Based on Desired Resources

To modify the deployment based on the desired resources including CPU, GPU, Disk, and RAM:

1. Open the `deploy.yaml` file.
2. Locate the `profiles` section.
3. Under each service (e.g., `ray-head`, `ray-worker`), adjust the resource values to match your requirements:
   - For CPU, modify the `cpu.units` value.
   - For GPU, modify the `gpu.units` value and ensure the `attributes.vendor.nvidia.model` matches your desired GPU model.
   - For Disk, modify the `storage.size` value.
   - For RAM, modify the `memory.size` value.
4. Save the changes and use this updated YAML file for deployment.

Remember to review and update the `placement` and `deployment` sections to reflect the correct pricing and count of nodes for your deployment.
