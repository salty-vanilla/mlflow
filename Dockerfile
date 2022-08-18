ARG PYTHON_TAG=3.9.13-slim-buster
ARG MLFLOW_VERSION=1.28.0

FROM python:${PYTHON_TAG}

ARG MLFLOW_VERSION

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
      curl \
      gcc \
      default-mysql-client \
      default-libmysqlclient-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install -U pip && \
    pip install \
        mlflow==${MLFLOW_VERSION} \
        mysql-connector-python \
        mysqlclient

EXPOSE 5000

CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --backend-store-uri ${BACKEND_STORE_URI} \
    --default-artifact-root ${DEFAULT_ARTIFACT_ROOT}