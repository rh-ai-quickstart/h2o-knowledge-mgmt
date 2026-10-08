.PHONY: setup test lint dev helm-lint

setup:
	uv sync --package h2o-knowledge-mgmt-api --extra dev

test:
	uv run --package h2o-knowledge-mgmt-api --extra dev pytest

lint:
	uv run --package h2o-knowledge-mgmt-api --extra dev ruff check .

dev:
	uv run --package h2o-knowledge-mgmt-api uvicorn h2o_knowledge_mgmt_api.main:app --reload --app-dir packages/api/src

helm-lint:
	helm lint deploy/helm/h2o-knowledge-mgmt
