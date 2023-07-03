# Benchmark Providers AI performance
This is an example benchmark from huggingface transformers.
so people can test provider performance and abilities.
this image contains to over 200 ai models for anyone that wants to build it further.

No action is needed the final results and gpu model will show in the deployment Log output.

SSH access to allow people easy access to tinker

#More information
https://github.com/huggingface/transformers


#Commands for running the benchmark over SSH.

python3 -m venv env ;
source env/bin/activate ;
pip3 install torch ;
pip3 install transformers ;
pip3 install py3nvml ;
python3 /transformers/examples/pytorch/benchmarking/run_benchmark.py --models bert-base-cased --batch_size=512 ;
