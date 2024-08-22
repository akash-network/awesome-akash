FROM ubuntu:24.04

# Aggiorna il sistema e installa le dipendenze necessarie
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    python3.12 \
    python3-setuptools \
    python3-pip \
    ffmpeg

RUN mkdir -p ~/.config/pip && printf "[global]\nbreak-system-packages = true\nroot-user-action = ignore\n" > ~/.config/pip/pip.conf

#RUN pip install --upgrade pip
RUN python3 -m pip install --user --no-warn-script-location --upgrade pip && ln -sf ~/.local/bin/pip /usr/local/bin/pip
RUN pip install -U openai-whisper

WORKDIR /app

CMD ["whisper"]
