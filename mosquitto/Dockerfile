FROM eclipse-mosquitto:1.6

ENV MOSQUITTO_CONFIGURATION_DIR="/mosquitto/config"
ENV MOSQUITTO_CONFIGURATION_FILE="${MOSQUITTO_CONFIGURATION_DIR}/mosquitto.conf"
ENV MOSQUITTO_PASSWORD_FILE="${MOSQUITTO_CONFIGURATION_DIR}/passwd"
ENV MOSQUITTO_ACL_FILE="${MOSQUITTO_CONFIGURATION_DIR}/acl"

COPY *.template "${MOSQUITTO_CONFIGURATION_DIR}/"

# Replace entrypoint set by mosquitto
# see https://github.com/docker-library/repo-info/blob/master/repos/eclipse-mosquitto/local/1.6.md
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD mosquitto -c ${MOSQUITTO_CONFIGURATION_FILE}

ENTRYPOINT ["/docker-entrypoint.sh"]
