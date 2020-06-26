FROM ubuntu:20.04

ENV TAPYRUS_VERSION='v0.4.0'

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/chaintope/tapyrus-signer/releases/download/${TAPYRUS_VERSION}/tapyrus-signer-${TAPYRUS_VERSION}-x86_64-px-linux-gnu.tar.gz && \
    tar -xzvf tapyrus-signer-${TAPYRUS_VERSION}-x86_64-px-linux-gnu.tar.gz tapyrus-signer-${TAPYRUS_VERSION}-x86_64-px-linux-gnu/bin && \
    mv tapyrus-signer-${TAPYRUS_VERSION}-x86_64-px-linux-gnu/bin/* /usr/local/bin/ && \
    rm -rf tapyrus-signer-${TAPYRUS_VERSION}-x86_64-px-linux-gnu.tar.gz tapyrus-signer-${TAPYRUS_VERSION}-x86_64-px-linux-gnu/

ENV CONF_DIR='/etc/tapyrus'
RUN mkdir ${CONF_DIR}

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["tapyrus-signerd -c ${CONF_DIR}/signer.toml"]
