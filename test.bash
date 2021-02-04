#! /bin/bash

set -e
set -o pipefail

CHART_INSTALL_TIMEOUT="1m"

command -v helm &> /dev/null || { echo "can't find helm command" && exit 1; }
command -v kind &> /dev/null || { echo "can't find kind command" && exit 1; }

make docker-build
helm lint ./charts/mockhelmrepo
kind create cluster
kind load docker-image $(make proxy-img)
kind load docker-image $(make repo-img)
helm install --wait --timeout=${CHART_INSTALL_TIMEOUT} --set=proxy.image.repository=$(make proxy-repo),proxy.image.tag=$(make img-version) --set=repo.image.repository=$(make repo-repo),repo.image.tag=$(make img-version) mockhelmrepo ./charts/mockhelmrepo
kind delete cluster
