# Github Runner with SSH

1. Get the token for registering your runner https://github.com/<org>/<repo>/settings/actions/runners/new
2. Set your repo & token in deploy.yaml file
3. (Optionally) set your public SSH key in deploy.yaml file so you can ssh to your gh runner

## For devs

If you want to build your own image:

```
docker login
docker build -t <yourDockerHubUsername>/ghrunner:2.305.0 .
docker push <yourDockerHubUsername>/ghrunner:2.305.0
```
