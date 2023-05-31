#!/bin/bash

#Upgrade pip
pip install --upgrade pip

# Clone the Auto-GPT repository
git clone https://github.com/Significant-Gravitas/Auto-GPT.git /app

# Set the working directory
cd /app

git checkout stable

pip install --no-cache-dir -r requirements.txt

gotty -w --random-url-length 16 python -m autogpt
