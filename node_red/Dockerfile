# Copyright 2019 Wirepas Ltd
# Upstream image: https://hub.docker.com/r/nodered/node-red
#

FROM nodered/node-red:1.0.3
ENV WIREPAS_FOLDER=/wirepas
ENV FLOWS="${WIREPAS_FOLDER}/wm-red-flow.json"


USER root
COPY wm-red-flow.json "${WIREPAS_FOLDER}/wm-red-flow.json"
RUN git clone https://github.com/wirepas/backend-apis.git backend-apis \
    && mkdir -vp "${WIREPAS_FOLDER}/protos" \
    && cp -v backend-apis/gateway_to_backend/protocol_buffers_files/*.proto "${WIREPAS_FOLDER}/protos" \
    && rm -rf backend-apis
COPY package.json /usr/src/node-red/
RUN chown -R node-red:node-red "${WIREPAS_FOLDER}"

USER node-red
RUN npm install


