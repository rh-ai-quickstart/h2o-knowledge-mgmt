# H2O Knowledge Management

> **WORK IN PROGRESS - NOT READY FOR USE**

This repository is an early scaffold for an AI Quickstart exploring knowledge management with H2O.ai and Red Hat OpenShift AI. It currently contains a minimal FastAPI service, a unit test, and a Helm chart. Product behavior, data flows, and deployment requirements are still to be defined.

## Repository layout

```text
packages/api/                       Python API package and unit tests
deploy/helm/h2o-knowledge-mgmt/     Helm chart
```

## Local development

Install [uv](https://docs.astral.sh/uv/) and Python 3.12 or newer, then run:

```bash
make setup
make test
make lint
make dev
```

The API exposes `GET /healthz` on port `8000` as a basic liveness endpoint.

## Container image

Build the API image from the repository root:

```bash
podman build -f packages/api/Containerfile -t h2o-knowledge-mgmt-api:dev .
```

## Helm chart

The chart is at `deploy/helm/h2o-knowledge-mgmt`. Set `image.repository` and `image.tag` to an image available to your cluster before installing it:

```bash
helm upgrade --install h2o-knowledge-mgmt deploy/helm/h2o-knowledge-mgmt \
  --set image.repository=your-registry/h2o-knowledge-mgmt-api \
  --set image.tag=dev
```
