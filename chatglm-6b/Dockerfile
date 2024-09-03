##thudm
FROM library/ubuntu:20.04

WORKDIR /

RUN apt update && apt install git python3 python3-pip -y && git clone https://github.com/THUDM/ChatGLM-6B.git && rm ChatGLM-6B/web_demo.py && pip3 install -r ChatGLM-6B/requirements.txt && rm -rf ChatGLM-6B/web_demo.py

WORKDIR ChatGLM-6B

ADD web_demo.py .

EXPOSE 7860

ENTRYPOINT ["python3", "web_demo.py"]
