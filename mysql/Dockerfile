# Copyright 2019 Wirepas Ltd

FROM mysql:5.7

COPY *.template .
COPY entrypoint_wrapper.sh /usr/local/bin/

ENTRYPOINT ["entrypoint_wrapper.sh"]
CMD ["mysqld"]
