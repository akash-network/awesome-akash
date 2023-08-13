# Torchbench SDL

## Choosing SDL 

Certain older cards such as the P4 and K80 do not support CUDA 12.  If you are on a card that has been dropped from cuda 12 support you will need to run the cuda 11.7 SDL .

Newer Cards support CUDA 12 and should use the CUDA 12 SDL. If your card was first released less than 4 years ago, than you will probably want to use the CUDA 12 SDL.

## Jupyterlab Notebook

The container for benchmarking is a jupyterlab notebook with [torchbench](https://github.com/pytorch/benchmark) installed. 

Jupyterlab will be accessible with a default password with 'passwd' or whatever you set in the SDL environemnt variable JUPYTER_TOKEN on the endpoint url for the service.  

An example notebook with instructions on how to submit benchmarks is included. After putting in the password you will need to open the Notebook "Akash_Gpu_Benchmark_Notebook.ipynb" by double clicking on the notebook in left panel. 

The notebook contains a form and instructions for submitting the benchmark information. 

##

