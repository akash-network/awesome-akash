# Doccano 

The `deploy.yaml` deploys a [Doccano](https://github.com/doccano/doccano) environment, which is a popular annotation tool for data scientists today. More specifically, the `deploy.yaml` specifies the `https://hub.docker.com/r/doccano/doccano` which is the official doccano image.

## Usage
Once deployed, Doccano can be accessed at `http:<HOSTED URI>:<REDIRECTED_PORT>`. The `ADMIN_USERNAME` and `ADMIN_PASSWORD` are set in the `deploy.yaml` file. By default, the admin username is 'admin' and the password is 'passowrd'.
For more information about management of user, please visit the official documentation at <https://doccano.github.io/doccano/>.