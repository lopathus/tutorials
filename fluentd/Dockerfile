# Wirepas Oy

FROM fluent/fluentd:v1.7
USER root
RUN apk add --update --virtual .build-deps \
        build-base ruby-dev \
    && gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-genhashvalue \
    && gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.5.0/cache/*.gem
COPY fluent.conf /fluentd/etc/fluent.conf
USER fluent
