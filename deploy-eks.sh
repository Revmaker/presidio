#!/bin/bash

set -e
set -o pipefail

env=$1
version=$2
region=${3:-us-east-1}

if [ -z "$env" ] || [ -z "$version" ]; then
    echo "Usage: $0 <env> <version> [<region>]"
    echo "          <region> defaults to 'us-east-1' unless specified"
    exit 1
fi

cd kubernetes

/usr/local/bin/kustomize build overlays/${region}/${env} | /usr/local/bin/kubectl --kubeconfig ~/.kube/${env}--${region}.config apply -f -
