.DEFAULT_GOAL := help

SHELL := /usr/bin/env bash

SOURCE := github.com/dcwangmit01/docker-nsrt-mk3-dev-logger
PACKAGE := dcwangmit01/nsrt-mk3-dev-logger
VERSION := 0.3.0

.PHONY: build
build: format reqs  ## Build the docker image
	docker build --tag $(PACKAGE):$(VERSION) .

.PHONY: push
push:  ## Push the docker image
	docker push $(PACKAGE):$(VERSION)

.PHONY: run
run:  ## Run the docker image
	docker run --rm -it \
	 --volume ./measurements:/measurements \
	 --device $(shell find /dev/serial -name usb-Convergence_Instruments_NSRT_mk3_Dev-*) \
	 $(PACKAGE):$(VERSION)

.PHONY: reqs
reqs:  ## Generate the requirements.txt file
	source .venv/bin/activate && \
	  pipreqs . --ignore .venv --force

.venv:  ## Create the virtual env for Python development
	python3 -m venv .venv
	source .venv/bin/activate && \
	  pip install flake8 black pipreqs && \
	  pipreqs ./ --ignore .venv --force && \
	  pip install -r requirements.txt

.PHONY: deps
deps: .venv  ## Install Dependencies

.PHONY: format
format: deps  ## Auto-format and check pep8
	@source .venv/bin/activate && \
	  black --line-length 79 *.py && \
	  flake8 *.py

.PHONY: clean
clean:  ## Clean all temporary files and images
clean:
	docker rm -f $(PACKAGE):$(VERSION)

.PHONY: mrclean
mrclean: clean  ## MrClean everything
	rm -rf .venv

.PHONY: help
help:  ## Print list of Makefile targets
	@# Taken from https://github.com/spf13/hugo/blob/master/Makefile
	@grep --with-filename -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  cut -d ":" -f2- | \
	  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | sort
