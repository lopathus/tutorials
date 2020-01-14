#!/usr/bin/env bash
# Copyright 2019 Wirepas Ltd

set -e

USER=${1:-"opensource_user"}

PASSWORD="${RANDOM}${RANDOM}"
KEY_LENGTH=4096
DAYS_TO_EXPIRATION=720
SERIAL_FILE="./serial"
CA_CONF_PATH="ca.conf"


# generate_ca
# This function creates a certificate authority key and certificate for
# authenticating our requests
function generate_ca()
{
    # Create the CA Key and Certificate for signing Client Certs
    openssl genrsa  -out ca.key "${KEY_LENGTH}"
    openssl req -new \
                -sha512 \
                -x509 \
                -days "${DAYS_TO_EXPIRATION}" \
                -key ca.key \
                -out ca.crt \
                -subj "/C=FI/ST=CITY/L=CITY/O=Company/OU=Opensource/CN=domain.com" 2>/dev/null

    # Create the Server Key, CSR, and Certificate
    openssl genrsa -out server.key "${KEY_LENGTH}"
    openssl req -new \
                -sha512 \
                -key server.key \
                -out server.csr \
                -subj "/C=FI/ST=CITY/L=CITY/O=Company/OU=Opensource/CN=domain.com" 2>/dev/null

    # We're self signing our own server cert here.  This is a no-no in production.
    openssl x509 -req \
                -days "${DAYS_TO_EXPIRATION}" \
                -in server.csr \
                -CA ca.crt \
                -CAkey ca.key  \
                -CAcreateserial \
                -out server.crt 2>/dev/null

    return 0
}


# generate_client
# This function generates a client certificate
function generate_client()
{


    if [[ ! -f "${SERIAL_FILE}" ]]
    then
        _USER_SERIAL="01"
        touch "${SERIAL_FILE}"
        touch index.txt
    fi

    _OUTPUT_DIR="users/${USER}"
    _USER_SERIAL=$(< "${SERIAL_FILE}" )
    _USER_SERIAL="0$((_USER_SERIAL+1))"
    _USER_FILENAME="${_OUTPUT_DIR}/${USER}_${_USER_SERIAL}"

    echo "Creating certificate for ${USER} with serial ${_USER_SERIAL} in ${_USER_FILENAME}"
    echo "${_USER_SERIAL}" > "${SERIAL_FILE}"

    mkdir -p "${_OUTPUT_DIR}"

    openssl genrsa -out "${_USER_FILENAME}.key" "${KEY_LENGTH}"
    openssl req -new\
                -sha512 \
                -key "${_USER_FILENAME}.key" \
                -out "${_USER_FILENAME}.csr" \
                -subj "/C=FI/ST=CITY/L=CITY/O=Company/OU=Opensource/CN=${USER}" 2>/dev/null
    openssl ca -batch \
               -config "${CA_CONF_PATH}" \
               -notext \
               -in "${_USER_FILENAME}.csr" \
               -out "${_USER_FILENAME}.crt" 2>/dev/null

    openssl x509 -req \
                 -days "${DAYS_TO_EXPIRATION}" \
                 -in "${_USER_FILENAME}.csr" \
                 -CA ca.crt \
                 -CAkey ca.key \
                 -set_serial "${_USER_SERIAL}" \
                 -out "${_USER_FILENAME}.crt" 2>/dev/null

    openssl ca -config "${CA_CONF_PATH}" \
               -gencrl \
               -keyfile ca.key \
               -cert ca.crt \
               -out root_crl.pem 2>/dev/null

    # Create pkcs2 for browser
    cat "${_USER_FILENAME}.key" > "${_USER_FILENAME}.pem"
    cat "${_USER_FILENAME}.crt" >> "${_USER_FILENAME}.pem"
    openssl pkcs12 -export -passout "pass:${PASSWORD}" \
                   -clcerts\
                   -in "${_USER_FILENAME}.crt" \
                   -inkey "${_USER_FILENAME}.key" \
                   -out "${_USER_FILENAME}.p12" 2>/dev/null

    return 0
}

# revoke_user
# This function revokes a user certificate
function revoke_user()
{
    openssl ca -config "${CA_CONF_PATH}" \
               -revoke "${_USER_FILENAME}.crt" \
               -keyfile ca.key  \
               -cert ca.crt 2>/dev/null
    openssl ca -config "${CA_CONF_PATH}" \
               -gencrl \
               -keyfile ca.key \
               -cert ca.crt \
               -out root_crl.pem 2>/dev/null
}


function clean()
{
    rm -r *.key *.crt *.pem *.csr index* serial* *.srl *.p12 users/*
}


function _main()
{

    clean || true
    if [[ ! -f ./ca.key ]]
    then
        generate_ca
    fi

    generate_client
}

_main

