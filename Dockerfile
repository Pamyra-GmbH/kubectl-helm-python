FROM python:alpine3.10

RUN pip install pyyaml pyaes

ARG VCS_REF
ARG BUILD_DATE

RUN apk add --update ca-certificates curl bash openssl \
 && apk add --update -t deps wget git  \
 && apk del --purge deps \
 && rm /var/cache/apk/* 

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
 && chmod 700 get_helm.sh \
 && ./get_helm.sh
 
ENV KUBE_LATEST_VERSION="v1.16.2"

RUN apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
