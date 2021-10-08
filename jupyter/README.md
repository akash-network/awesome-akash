# Jupyter Notebook

The `deploy.yaml` deploys a [Jupyter notebook](https://jupyter.org/) environment, which is a popular user interface for data scientists today. More specifically, the `deploy.yaml` specifies the `jupyter/tensorflow-notebook` image that includes popular Python deep learning libraries, but one can easily swap it out with the various Jupyter environment images provided by [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html).

## Usage
Once deployed, the Jupyter notebook can be accessed at `http:<HOSTED URI>`. To obtain the access token, you would need to view the provider lease logs (i.e. via the CLI `akash provider lease-logs` command), and paste it into the input to authenticate.