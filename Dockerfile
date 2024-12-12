ARG IMAGE=keycloak/keycloak
ARG VERSION=latest

FROM --platform=$BUILDPLATFORM $IMAGE:$VERSION

WORKDIR /opt/keycloak

COPY ./improvised_secrets.sh /opt/keycloak/bin/improvised_secrets.sh

RUN /opt/keycloak/bin/kc.sh build --db=postgres

ENTRYPOINT ["/opt/keycloak/bin/improvised_secrets.sh", "/opt/keycloak/bin/kc.sh"]

LABEL org.opencontainers.image.title=pg-keycloak
LABEL org.opencontainers.image.description="Keycloak with support for Docker secrets, prebuild for postgres db."
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/dsbferris/pg-keycloak
