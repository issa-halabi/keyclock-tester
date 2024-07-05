FROM quay.io/keycloak/keycloak:22.0.5 as builder

COPY providers/keycloak-phone-provider.jar /opt/keycloak/providers/
COPY providers/keycloak-phone-provider.resources.jar /opt/keycloak/providers/
# COPY providers/keycloak-sms-provider-dummy.jar /opt/keycloak/providers/
COPY providers/keycloak-sms-provider-aws-sns.jar /opt/keycloak/providers/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:22.0.5

COPY --from=builder /opt/keycloak/providers/ /opt/keycloak/providers/
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
