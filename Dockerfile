ARG IMAGE=quay.io/keycloak/keycloak
ARG VERSION=latest
FROM ${IMAGE}:${VERSION}

ARG KC_DB=postgres
ARG KC_HEALTH_ENABLED=true
ARG KC_METRICS_ENABLED=true

ENV KC_HEALTH_ENABLED=$KC_HEALTH_ENABLED
ENV KC_METRICS_ENABLED=$KC_METRICS_ENABLED
ENV KC_DB=$KC_DB

WORKDIR /opt/keycloak

#RUN /opt/keycloak/bin/kc.sh build

COPY ./improvised_secrets.sh /opt/keycloak/bin/improvised_secrets.sh


ENTRYPOINT ["/opt/keycloak/bin/improvised_secrets.sh", "/opt/keycloak/bin/kc.sh"]

LABEL org.opencontainers.image.title=pg-keycloak
LABEL org.opencontainers.image.description="Postgres Keycloak with support for Docker secrets."
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/dsbferris/pg-keycloak
