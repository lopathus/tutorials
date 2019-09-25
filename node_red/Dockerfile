# Copyright 2019 Wirepas Ltd

FROM nodered/node-red-docker:v8

USER root
RUN git clone https://github.com/wirepas/backend-apis.git backend-apis \
    && mkdir -p /data/protos/ \
    && cp backend-apis/gateway_to_backend/protocol_buffers_files/*.proto /data/protos/ \
    && chown -R node-red:node-red /data/protos/ \
    && rm -rf backend-apis

USER node-red
COPY package.json /usr/src/node-red/
RUN npm install

COPY wm-red-flow.json /data/wm-red-flow.json
ENV FLOWS=/data/wm-red-flow.json
