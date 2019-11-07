#!/bin/ash
# Wirepas Ltd

set -e

MQTT_USERNAME=${MQTT_USERNAME:-${WM_SERVICES_MQTT_USERNAME}}
MQTT_PASSWORD=${MQTT_PASSWORD:-${WM_SERVICES_MQTT_PASSWORD}}

MQTT_GENERATED_PASSWORD_SIZE=${MQTT_GENERATED_PASSWORD_SIZE:-25}

generate_settings()
{
    TEMPLATE=${1}
    OUTPUT_PATH=${2}

    if [ -f "${OUTPUT_PATH}" ]
    then
        rm -f "${OUTPUT_PATH}" "${OUTPUT_PATH}.tmp"
    fi

    ( echo "cat <<EOF >${OUTPUT_PATH}";
      cat "${TEMPLATE}";
      echo "EOF";
    ) > "${OUTPUT_PATH}.tmp"
    # shellcheck source=/dev/null
    . "${OUTPUT_PATH}.tmp"
    rm "${OUTPUT_PATH}.tmp"

    sed -i "/NOTSET/d" "${OUTPUT_PATH}"
}

set -e

rm -f "${MOSQUITTO_PASSWORD_FILE}"
touch "${MOSQUITTO_PASSWORD_FILE}"

generate_settings "${MOSQUITTO_ACL_FILE}.template" "${MOSQUITTO_ACL_FILE}"
generate_settings "${MOSQUITTO_CONFIGURATION_FILE}.template" "${MOSQUITTO_CONFIGURATION_FILE}"


if [ -z "${MQTT_PASSWORD}" ]
then
    MQTT_PASSWORD=$(</dev/urandom \
                    tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' \
                    | head -c "${MQTT_GENERATED_PASSWORD_SIZE}")
    echo "GENERATED PASSWORD: ${MQTT_PASSWORD}"
fi

mosquitto_passwd -b "${MOSQUITTO_PASSWORD_FILE}" "${MQTT_USERNAME}" "${MQTT_PASSWORD}"

exec "$@"


