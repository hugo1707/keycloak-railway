FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

CMD ["start", "--optimized", "--hostname-url", "HOSTNAME", "-Djboss.http.port", $PORT]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]