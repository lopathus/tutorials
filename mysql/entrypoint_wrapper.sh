#!/bin/bash
# Wirepas Ltd

set -e
set -x

export MYSQL_DATABASE
export MYSQL_USER
export MYSQL_PASSWORD
export MYSQL_ROOT_PASSWORD
export MYSQL_USER
export TZ

MYSQL_DATABASE=${MYSQL_DATABASE:-${WM_SERVICES_MYSQL_DATABASE}}
MYSQL_USER=${MYSQL_USER:-${WM_SERVICES_MYSQL_USERNAME}}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-${WM_SERVICES_MYSQL_PASSWORD}}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-${WM_SERVICES_MYSQL_PASSWORD}}
TZ=${TZ:-${WM_SERVICES_MYSQL_TZ}}

generate_init_script()
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

    cat "${OUTPUT_PATH}"
}


generate_init_script "config.sql.template" \
                     "/docker-entrypoint-initdb.d/wm-init-db.sql"

docker-entrypoint.sh "$@"
