FROM python:3.6
RUN pip install awscli
RUN curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -o /tmp/helm.tar.gz && \
    tar -xvf /tmp/helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/ && \
    chmod 755 /usr/local/bin/helm