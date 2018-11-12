#!/bin/bash

yum -y install git
git config --global user.email "jkd-showk@googlegroups.com"
git config --global user.name "showKs CI"

curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -o /tmp/helm.tar.gz
tar -xvf /tmp/helm.tar.gz
mv linux-amd64/helm /usr/local/bin/
chmod 755 /usr/local/bin/helm

IMAGE_TAG=${TAG_PREFIX}`git --git-dir ./app/.git rev-parse HEAD`
BRANCH=`git --git-dir ./k8s-manifests/.git rev-parse --abbrev-ref HEAD`

cp -ar k8s-manifests changed-k8s-manifests

ls -al

ls -al k8s-manifests/
ls -al changed-k8s-manifests/

cd changed-k8s-manifests/
mkdir -p manifests/${APP_NAME}/
helm template helm/${APP_NAME} --set image.tag=${IMAGE_TAG} > manifests/${APP_NAME}/manifest.yaml
git add .
git commit -m "update ${BRANCH} image to ${APP_NAME}:${IMAGE_TAG}"

