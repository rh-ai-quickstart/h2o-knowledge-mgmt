"""Minimal API application scaffold."""

from fastapi import FastAPI

app = FastAPI(
    title="H2O Knowledge Management API",
    description="Work in progress; not ready for use.",
    version="0.1.0",
)


@app.get("/healthz", tags=["health"])
def health_check() -> dict[str, str]:
    """Report that the API process is responding."""
    return {"status": "ok"}
