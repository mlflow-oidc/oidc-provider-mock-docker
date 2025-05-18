ARG PYTHON_VERSION=3.13-alpine3.21
FROM python:${PYTHON_VERSION} AS base

LABEL org.opencontainers.image.authors="Alexander Kharkevich <alex@kharkevich.org>"
LABEL org.opencontainers.image.source="http://github.com/mlflow-oidc/oidc-provider-mock-docker"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.description="OpenID Provider Mock Server docker image"

RUN apk add --no-cache pipx socat
RUN addgroup -S app -g 1001 && adduser -S app -G app -u 1001
USER app
WORKDIR /home/app
ENTRYPOINT [ "sh", "-c", "socat TCP-LISTEN:8080,fork TCP:localhost:9400 & pipx run --spec oidc-provider-mock oidc-provider-mock --port 9400" ]
