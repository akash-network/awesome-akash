# Ray Deployment Summary

This repository contains Dockerfiles and deployment configurations for Ray clusters, specifically optimized for GPU-based workloads with Python 3.10 and CUDA 11.8 support. The provided Docker images and deployment examples facilitate the setup of Ray clusters for scalable and distributed computing. 

## Container Details

- `thumperai/rayakash:ray-head-gpu-py310-cu118`: This Docker image is for the head node of a Ray cluster. It orchestrates the cluster's activities and manages resources.

- `thumperai/rayakash:ray-worker-py310-cu118`: This Docker image is for the worker nodes of a Ray cluster. These nodes execute the tasks scheduled by the head node.

starthead.sh is used to launch the head node of the ray cluster.  It is a simple script that launches the ray head node with the appropriate environment variables because Akash doesn't allow the inclusion of ports in the deployment SDL. 

## Customizing Ray Container Versions

To customize the versions of CUDA, Ray, or Python used in your Ray cluster using the Dockerfile from DockerHub (`rayproject/ray-ml:nightly-py310-cu118`):

Please ensure that the versions you select are compatible with each other. Incompatible versions may result in errors during the build or runtime of your Ray cluster. Remember the head and worker nodes must run the same version of Python and Ray. 

## Ports Details

The deployment utilizes several ports for different services. These include:

- `8265`: This port is used for the Ray dashboard and jobs endpoint.
- `6380`: This port is used for the Ray service.

## Deployment Instructions

1. Build the Docker images using the provided Dockerfiles.
```
cd ray-head-gpu && docker build -t  thumperai/rayakash:ray-head-gpu-py310-cu118 .
cd .. 
cd ray-worker-gpu && docker build -t  thumperai/rayakash:ray-worker-py310-cu118 .
```

2. Push the images to a container registry.
```docker push thumperai/rayakash:ray-head-gpu-py310-cu118
   docker push thumperai/rayakash:ray-worker-py310-cu118
 ```
3. Use the `deployment_example.yaml` file as a template to configure your Ray cluster deployment.

4. Modify the `resources` section under `profiles` in the `deployment_example.yaml` to match the desired number of CPUs and other resources for each node type.  Remmember that providers will sometimes have different gpu model tags in use.  This example deployment may need to be scaled down to bid on your preferred provider. 

5. Deploy the Ray cluster using the configured YAML file.  Go to https://console.akash.network/ and paste in your yaml file to deploy your cluster. 

## Environment Variables

The deployment utilizes several environment variables for configuration. These include:

- `RAY_ADDRESS_HOST`: Specifies the address of the head node. Only edit if you are trying to use ray across multiple providers.
- `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`: Credentials for AWS services.
- `R2_BUCKET_URL`, `S3_ENDPOINT_URL`: URLs for S3-compatible storage services.
- `B2_APPLICATION_KEY_ID`, `B2_APPLICATION_KEY`: Credentials for Backblaze B2 storage.
- `MINIO_ACCESS_KEY`, `MINIO_SECRET_KEY`: Credentials for MinIO storage.
- `AWS_DEFAULT_REGION`: The default AWS region for services.
- `WANDB_API_KEY`, `WANDB_PROJECT`: Credentials and project name for Weights & Biases logging.

Note: If you are training with multiple GPUs, you will need to set environment variables for PyTorch, NCCL and CUDA. For example, you might need to set `NCCL_IB_GID_INDEX`, `NCCL_BLOCKING_WAIT`, `NCCL_DEBUG`, and `TORCH_DISTRIBUTED_DETAIL`. Refer to your specific GPU and CUDA documentation for the appropriate settings.

Ensure to replace the placeholder values (denoted by `XXXXXXXXXXXXXXXXXXXXX`) with your actual credentials and URLs.

## Modifying Deployment Based on Desired Resources

To modify the deployment based on the desired resources including CPU, GPU, Disk, and RAM:

1. Open the `deployment_example.yaml` file.
2. Locate the `profiles` section.
3. Under each service (e.g., `ray-head`, `ray-worker`), adjust the resource values to match your requirements:
   - For CPU, modify the `cpu.units` value.
   - For GPU, modify the `gpu.units` value and ensure the `attributes.vendor.nvidia.model` matches your desired GPU model.
   - For Disk, modify the `storage.size` value.
   - For RAM, modify the `memory.size` value.
4. Save the changes and use this updated YAML file for deployment.

For example, to allocate specific resources to the head node and worker nodes, you would set the following under `ray-head` and `ray-worker` profiles respectively:

Remember to review and update the `placement` and `deployment` sections to reflect the correct pricing and count of nodes for your deployment.
