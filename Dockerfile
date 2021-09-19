FROM python:3.9-slim-bullseye

ENV GAMADV_VERSION=6.07.30
ENV DEBIAN_FRONTEND=noninteractive
ENV GAMUSERCONFIGDIR=/gam/src

COPY gam-wrapper.sh /usr/bin/gam-wrapper.sh

RUN BUILD_TOOLS="curl swig gcc libpcsclite-dev xz-utils" \
    && apt-get update \
    && apt-get install -yqq ${BUILD_TOOLS} \
    && cd /tmp \
    && curl -L -o /tmp/v$GAMADV_VERSION.tar.gz https://github.com/taers232c/GAMADV-XTD3/archive/v$GAMADV_VERSION.tar.gz \
    && mkdir /gam \
    && tar -C /gam -zxf /tmp/v$GAMADV_VERSION.tar.gz \
    && cd /gam && mv GAMADV-XTD3-${GAMADV_VERSION}/* . \
    && pip install --no-cache-dir -r /gam/src/requirements.txt \
    && touch /gam/src/nobrowser.txt /gam/src/noupdatecheck.txt \
    && rm -rf /gam/GAM-${GAMADV_VERSION} \
    && chmod 0755 /usr/bin/gam-wrapper.sh \
    && apt remove -yqq $BUILD_TOOLS \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

WORKDIR /gam

ENTRYPOINT [ "/usr/bin/gam-wrapper.sh" ]
