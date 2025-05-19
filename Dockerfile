ARG PYTHON_VERSION=3.13-alpine3.21
FROM library/python:${PYTHON_VERSION} AS base

LABEL org.opencontainers.image.authors="Alexander Kharkevich <alex@kharkevich.org>"
LABEL org.opencontainers.image.source="http://github.com/mlflow-oidc/oidc-provider-mock-docker"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.description="OpenID Provider Mock Server docker image"
ENV PIP_ROOT_USER_ACTION=ignore
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
RUN apk add --no-cache socat curl \
    && pip install --no-cache-dir oidc-provider-mock
RUN addgroup -S app -g 1001 && adduser -S app -G app -u 1001
USER app
WORKDIR /home/app
ENTRYPOINT [ "sh", "-c", "socat TCP-LISTEN:8080,fork TCP:localhost:9400 & oidc-provider-mock --port 9400" ]
