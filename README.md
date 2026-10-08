# H2O Knowledge Management

> **WORK IN PROGRESS - NOT READY FOR USE**

This repository is an early scaffold for an AI Quickstart exploring knowledge management with H2O.ai and Red Hat OpenShift AI.

It currently contains a small Python API scaffold deployed with Helm alongside S3-compatible storage. On install, a Job uploads the configured sample document to the `documents` bucket. The API currently provides a health endpoint at `/healthz`.

## Repository layout

```text
packages/api/                    Python API and tests
deploy/helm/h2o-knowledge-mgmt/  Helm chart for the API, S3 storage, and document upload
```

## Installation

```bash
make deploy
```

This uses the namespace from the current Kubernetes context. To deploy to a specific namespace (created if needed):

```bash
make deploy NAMESPACE=my-namespace
```

## Project teardown

Remove the deployment from the current namespace, or specify the namespace used during installation:

```bash
make undeploy
make undeploy NAMESPACE=my-namespace
```

## Make targets


| Target           | Purpose                                                              |
| ---------------- | -------------------------------------------------------------------- |
| `make setup`     | Install Python and development dependencies.                         |
| `make test`      | Run API tests.                                                       |
| `make lint`      | Check Python code style.                                             |
| `make dev`       | Run the API locally.                                                 |
| `make helm-lint` | Check the Helm chart.                                                |
| `make deploy`    | Install the API and S3 storage, then upload the configured document. |
| `make undeploy`  | Remove the deployment.                                               |
