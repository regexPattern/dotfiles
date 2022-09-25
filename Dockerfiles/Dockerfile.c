FROM ubuntu:22.04

RUN apt update -y && apt upgrade -y \
	&& apt install -y build-essential make valgrind
