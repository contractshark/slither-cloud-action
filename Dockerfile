# syntax=docker/dockerfile:1.2

FROM python:3.8-slim-buster
ENV PYTHONUNBUFFERED 1
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'


RUN curl -sSL "https://raw.githubusercontent.com/CircleCI-Public/cimg-node/master/ALIASES" -o nodeAliases.txt && \
	NODE_VERSION=$(grep "lts" ./nodeAliases.txt | cut -d "=" -f 2-) && \
	curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
	sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
	rm node.tar.xz nodeAliases.txt && \
	sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN pip install crytic-compile

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
