# Github Runner

1. Get the token for registering your runner `https://github.com/<org>/<repo>/settings/actions/runners/new`
2. Set your repo & token in deploy.yaml file

## For devs

If you want to build your own image:

```
docker login
docker build -t <yourDockerHubUsername>/ghrunner:2.306.0 .
docker push <yourDockerHubUsername>/ghrunner:2.306.0
```
