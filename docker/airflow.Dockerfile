ARG AIRFLOW_VERSION=2.0.2
ARG PYTHON_VERSION=3.8
FROM apache/airflow:${AIRFLOW_VERSION}-python${PYTHON_VERSION}

MAINTAINER Jianxiong <jack18588951684@163.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

USER root

RUN apt-get update --fix-missing && \
    apt-get install -y --allow-unauthenticated \
        build-essential \
        default-libmysqlclient-dev  \
        libpq-dev \
        sasl2-bin \
        libsasl2-2 \
        libsasl2-dev \
        libsasl2-modules && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# provider-packages
# https://airflow.apache.org/docs/#providers-packages-docs-apache-airflow-providers-index-html
RUN python -m pip install --user --upgrade pip && \
    pip install --no-cache-dir \
        celery==4.4.7 \
        flower==0.9.7 \
        psycopg2 \
        redis-py-cluster \
        clickhouse-driver \
        apache-airflow-providers-dingding \
        apache-airflow-providers-apache-hive \
        apache-airflow-providers-ssh

EXPOSE 8080 5555 8793

ENV AIRFLOW_HOME=/opt/airflow
ARG AIRFLOW_USER_NAME=aigroup
ARG AIRFLOW_USER_PASSWD=yl123456
ARG AIRFLOW_USER_ID=5000
ARG AIRFLOW_GROUP_ID=5000

RUN mkdir -p ${AIRFLOW_HOME} && \
    echo "${AIRFLOW_USER_NAME}:x:${AIRFLOW_USER_ID}:${AIRFLOW_GROUP_ID}::${AIRFLOW_HOME}:/bin/bash" >> /user.txt && \
    echo "${AIRFLOW_USER_NAME}:${AIRFLOW_USER_PASSWD}" >> /passwd.txt && \
    newusers < /user.txt && \
    pwunconv && \
    chpasswd < /passwd.txt && \
    pwconv && \
    rm /user.txt /passwd.txt && \
    mkdir -p "${AIRFLOW_HOME}/dags" && \
    mkdir -p "${AIRFLOW_HOME}/logs" && \
    mkdir -p "${AIRFLOW_HOME}/plugins" && \
    chown -R ${AIRFLOW_USER_ID}:${AIRFLOW_GROUP_ID} ${AIRFLOW_HOME} && \
    find "${AIRFLOW_HOME}" -executable -print0 | xargs --null chmod ug+x && \
    find "${AIRFLOW_HOME}" -print0 | xargs --null chmod ug+rw

USER ${AIRFLOW_USER_NAME}

WORKDIR ${AIRFLOW_HOME}

CMD ["bash"]