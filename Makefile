RELEASE ?= h2o-knowledge-mgmt
NAMESPACE ?=
HELM_ARGS ?=
CHART_DIR := deploy/helm/h2o-knowledge-mgmt
HELM_NAMESPACE_ARG = $(if $(strip $(NAMESPACE)),--namespace $(NAMESPACE),)
HELM_CREATE_NAMESPACE_ARG = $(if $(strip $(NAMESPACE)),--create-namespace,)

.PHONY: setup test lint dev helm-lint deploy undeploy

setup:
	uv sync --package h2o-knowledge-mgmt-api --extra dev

test:
	uv run --package h2o-knowledge-mgmt-api --extra dev pytest

lint:
	uv run --package h2o-knowledge-mgmt-api --extra dev ruff check .

dev:
	uv run --package h2o-knowledge-mgmt-api uvicorn h2o_knowledge_mgmt_api.main:app --reload --app-dir packages/api/src

helm-lint:
	helm lint $(CHART_DIR)

deploy:
	helm dependency update $(CHART_DIR)
	helm upgrade --install $(RELEASE) $(CHART_DIR) $(HELM_NAMESPACE_ARG) $(HELM_CREATE_NAMESPACE_ARG) $(HELM_ARGS)

undeploy:
	helm uninstall $(RELEASE) $(HELM_NAMESPACE_ARG)
