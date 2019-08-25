# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# The build rule builds a Docker image that logs all Docker contains logs to
# Google Compute Platform using the Cloud Logging API.

.PHONY:	build push

REPO=gcr.io
PROJECT:= $(shell gcloud config get-value project)
PREFIX := ${REPO}/${PROJECT}
TAG = 1.0.0
BUILD_DEPS="make gcc g++ libc6-dev ruby-dev libffi-dev"

build:
	docker build --pull -t $(PREFIX)/fluentd-gcp:$(TAG) .


push:
	gcloud docker -- push $(PREFIX)/fluentd-gcp:$(TAG)


update-dependencies: build
	docker run -it --name fluentd-gcp-refreeze $(PREFIX)/fluentd-gcp:$(TAG) /bin/sh -c 'clean-install "$(BUILD_DEPS)" && rm /Gemfile.lock && gem install --file Gemfile'
	docker cp fluentd-gcp-refreeze:/Gemfile.lock .
	docker rm fluentd-gcp-refreeze
