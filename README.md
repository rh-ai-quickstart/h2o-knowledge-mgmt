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

The chart also deploys the shared `aws-compatible-storage` chart. The API receives the internal S3 endpoint and credentials from the storage chart's Kubernetes Secret. The S3 endpoint is `http://h2o-knowledge-mgmt-storage:7480`; application features can choose and create buckets as they are implemented.

To create a `documents` bucket and upload sample documents during installation, enable the post-install job and provide HTTP or HTTPS URLs:

```yaml
sampleFileUpload:
  enabled: true
  bucket: documents
  region: us-east-1
  urls:
    - https://example.com/sample-document.pdf
```

The job runs in a UBI Python image, waits for S3 storage to become available, creates the bucket if needed, and stores each document under its filename. It installs `boto3` and `requests` at startup, so the cluster needs access to the Python package index. It starts during installation and remains available for inspection for up to 24 hours after completion. Changing the bucket, region, or URLs on a Helm upgrade creates a new upload job.
