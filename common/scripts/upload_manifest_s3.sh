#!/bin/bash
set -e

IMAGE_TAG=${TAG_PREFIX}`cat ./app/.git/refs/heads/${BRANCH}`

cp -ar k8s-manifests/* k8s-manifests/.git changed-k8s-manifests/
cd changed-k8s-manifests/
mkdir -p manifests/${APP_NAME}/
helm template ../app/helm/ --set image.tag=${IMAGE_TAG} --set nameSuffix=${NAME_SUFFIX} --set userID=${USERID} --set vhostDomain=${VHOST_DOMAIN} > manifests/${APP_NAME}/manifest.yaml

aws s3 cp manifests/${APP_NAME}/manifest.yaml s3://${TAG_PREFIX}showks-concourse-bucket/manifests/${APP_NAME}/manifest.yaml
