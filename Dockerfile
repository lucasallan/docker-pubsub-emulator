FROM openjdk:7u121-jdk-alpine

MAINTAINER Lucas Amorim <lucasamorim@protonmail.com>
EXPOSE 8042

LABEL version="1.0.0"
LABEL app="pubsub-emulator"

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV DATA_DIR "/data"
ENV HOST_PORT 8042

ENV APP_HOME /pubsub
WORKDIR $APP_HOME

RUN apk update
RUN apk add wget tar python

ENV PATH /opt/google-cloud-sdk/bin:$PATH
RUN mkdir -p /opt/gcloud && \
    wget --no-check-certificate --directory-prefix=/tmp/ https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && \
    unzip /tmp/google-cloud-sdk.zip -d /opt/ && \
    /opt/google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/opt/gcloud/.bashrc --disable-installation-options && \
    gcloud components install -q pubsub-emulator beta && \
    rm -rf /tmp/*

COPY . $APP_HOME

RUN mkdir -p ${DATA_DIR}

ADD start-pubsub $APP_HOME/start-pubsub

RUN chmod +x $APP_HOME/start-pubsub

CMD ["/pubsub/start-pubsub"]

