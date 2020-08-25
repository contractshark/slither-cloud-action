ARG PYTHON_VERSION=3.8

FROM python:${PYTHON_VERSION}

ARG NODE_VERSION=10

#ARG NVM_VERSION=0.35.3
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
#ENV NVM_DIR="/root/.nvm"
#RUN . /root/.nvm/nvm.sh && nvm install ${NODE_VERSION}
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && apt-get install -y nodejs

RUN pip install crytic-compile

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
