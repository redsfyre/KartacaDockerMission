FROM ubuntu:latest
MAINTAINER Yasin İsa YILDIRIM "yasinisayildirim@protonmail.com"
RUN apt update \
	&& apt install -y python-pip \
	&& apt install -y git
WORKDIR /mission
RUN git clone https://github.com/Sysnove/flask-hello-world.git .
RUN pip install -r requirements.txt
CMD python hello.py
EXPOSE 8000
