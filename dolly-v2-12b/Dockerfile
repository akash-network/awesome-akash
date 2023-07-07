FROM python:3.9

RUN apt-get -y update && apt-get upgrade -y
RUN pip install --upgrade pip
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu118
RUN pip install git+https://github.com/huggingface/transformers@main uvicorn fastapi accelerate google google-api-python-client scipy

WORKDIR /root/app

COPY . /root/app

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]
