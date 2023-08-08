from ubuntu:latest

RUN apt update && apt install -y python3 python3-pip

RUN pip install transformers torch einops xformers accelerate


WORKDIR /usr/app/src

COPY falcon7b.py ./

CMD python3 falcon7b.py && sleep infinity
