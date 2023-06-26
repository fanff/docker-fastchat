FROM python:3.10 AS baseimage

# Install OS dependencies
RUN apt-get update
RUN apt-get install -y software-properties-common

RUN apt-get install -y \
  git

WORKDIR /app/FastChat
# Install FastChat
# https://github.com/lm-sys/FastChat#method-2-from-source
RUN git clone https://github.com/lm-sys/FastChat.git .
RUN python -m pip install --upgrade pip




FROM baseimage AS controlerimg
RUN pip3 install fastAPI numpy requests uvicorn torch




FROM controlerimg AS webui
RUN pip install gradio 
RUN pip install psutil
RUN pip install transformers
RUN pip install accelerate
RUN pip install openai




FROM webui as vicuna7b
RUN pip install -e . 
RUN mkdir /models


