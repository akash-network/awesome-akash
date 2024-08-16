FROM python:3.9

WORKDIR /grok

RUN apt-get update && \
    apt-get install wget -y && \
    mkdir -p grok-model

RUN pip install --upgrade pip

RUN wget https://github.com/xai-org/grok-1/raw/main/tokenizer.model

COPY . /grok

RUN pip install --no-cache-dir -r /grok/requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]