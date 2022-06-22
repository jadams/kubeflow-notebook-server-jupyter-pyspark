FROM ghcr.io/jadams/kubeflow-notebook-server-jupyter:main

USER root

# install -- openjdk-17
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -yq update \
 && apt-get -yq install --no-install-recommends \
    openjdk-17-jdk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# install - requirements.txt
COPY --chown=jovyan:users requirements.txt /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
 && rm -f /tmp/requirements.txt
