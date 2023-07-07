# FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime
FROM tverous/pytorch-notebook:latest
RUN git clone https://github.com/pytorch/benchmark
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y pandoc texlive-xetex fonts-liberation texlive texlive-latex-extra libnss3
COPY run.sh /
COPY run.sh /app/
COPY run_tacotron.sh /app/
COPY run_cpu_only.sh /app/
COPY Akash_Gpu_Benchmark_Notebook.ipynb /app/Akash_Gpu_Benchmark_Notebook.ipynb
RUN chmod 777 -R /app/
RUN chmod 777 -R "${HOME}"
RUN pip3 install torchtext torchaudio torchvision seaborn nbconvert[all] pyppeteer
# RUN /opt/conda/bin/python3 -m pip install torch torchaudio torchvision torchtext

# ENTRYPOINT ["sh","./run.sh"]
# ENTRYPOINT ["jupyter notebook"]

# ENTRYPOINT ["python /workspace/benchmark/install.py models hf_bert hf_Bert_large resnet50 tacotron2 && pytest /workspace/benchmark/test_bench.py -k '(hf_bert or hf_bert_Large or resnet50 or tacotron2)' --ignore_machine_config"]
# running install at run time to reduce container size from 20Gb to about 7.
# RUN cd benchmark && python install.py
