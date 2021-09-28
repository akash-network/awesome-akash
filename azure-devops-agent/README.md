# Run azure devops agent on Akash

This template is to deploy an azure devops agent on the Akash network.

An azure devops agent can be used in azure devops pipelines to build and deploy applications.

Here is the docker image used by the template:
https://github.com/Odiovock/akash-azure-devops-agent

The port `3000` is not really needed. It was added because the providers were giving this error otherwise: `invalid manifest: zero global services`

## Environment Variables

These environment variables can be set in the `env` section of the SDL file.

| Name | Description                                                 |
|----------------------|-------------------------------------------------------------|
| AZP_URL              | The URL of the Azure DevOps or Azure DevOps Server instance. |
| AZP_TOKEN            | [Personal Access Token (PAT)](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate) with **Agent Pools (read, manage)** scope, created by a user who has permission to [configure agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues#creating-agent-pools), at `AZP_URL`.    |
| AZP_AGENT_NAME       | Agent name (default value: the container hostname).          |
| AZP_POOL             | Agent pool name (default value: `Default`).                  |
| AZP_WORK             | Work directory (default value: `_work`).                     |