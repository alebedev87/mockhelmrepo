BUILD_DIR := images
PROXY_DIR := $(BUILD_DIR)/reverseproxy
REPO_DIR := $(BUILD_DIR)/helmrepo

DOCKER_HUB := docker.io
IMG_REPO ?= $(DOCKER_HUB)
IMG_PROJECT ?= $(USER)
IMG_VERSION ?= $(shell git describe --tags --always --dirty)

PROXY_IMG_NAME ?= mockreverseproxy
REPO_IMG_NAME ?= mockhelmrepo

PROXY_IMG ?= $(IMG_PROJECT)/$(PROXY_IMG_NAME):$(IMG_VERSION)
REPO_IMG ?= $(IMG_PROJECT)/$(REPO_IMG_NAME):$(IMG_VERSION)

CHART := mockhelmrepo
CHART_PACKAGE ?= $(CHART)-$(IMG_VERSION).tgz

img-version:
	@echo $(IMG_VERSION)

proxy-repo:
	@echo $(IMG_PROJECT)/$(PROXY_IMG_NAME)

repo-repo:
	@echo $(IMG_PROJECT)/$(REPO_IMG_NAME)

proxy-img:
	@echo $(PROXY_IMG)

repo-img:
	@echo $(REPO_IMG)

docker-build:
	docker build -t $(PROXY_IMG) -f $(PROXY_DIR)/Dockerfile $(PROXY_DIR)
	docker build -t $(REPO_IMG) -f $(REPO_DIR)/Dockerfile $(REPO_DIR)

docker-push:
	docker push $(PROXY_IMG)
	docker push $(REPO_IMG)

helm:
	helm package --version=$(IMG_VERSION) --app-version=$(IMG_VERSION) charts/$(CHART)
	ln -sf $(CHART_PACKAGE) $(CHART).tgz

helm-pkg:
	@echo $(CHART_PACKAGE)
