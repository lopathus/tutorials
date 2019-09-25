# Elastic Search

Elasticsearch is a search engine based on the Lucene library. It provides a distributed,
multitenant-capable full-text search engine with an HTTP web interface and schema-free JSON documents.
See <https://www.elastic.co/subscriptions> for more details on the license terms of elasticsearch.

## Pre-requisites

Before you start using elastic search it is important to get familiar with
[Elastic's user guide and installation][es_guide].
In this page we focus on the Docker installation.

**One of the main requirements to have a successful spin up of Elasticsearch is to set the heap size of your machine correctly.**

Depending on your host and as [described in the official documentation][es_guide_docker]:

### Linux

        The vm.max_map_count setting should be set permanently in /etc/sysctl.conf:

        $ grep vm.max_map_count /etc/sysctl.conf
        vm.max_map_count=262144

        To apply the setting on a live system type:

        $ sysctl -w vm.max_map_count=262144

### macOS with Docker for Mac

        The vm.max_map_count setting must be set within the xhyve virtual machine:

        $ screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty

        Just press enter and configure the sysctl setting as you would for Linux:

        sysctl -w vm.max_map_count=262144

### Windows and macOS with Docker Toolbox\*\*

        The vm.max_map_count setting must be set via docker-machine:

        docker-machine ssh
        sudo sysctl -w vm.max_map_count=262144

## Starting elastic search

In this repository you will find an example on our to setup a single node
elasticsearch [docker-compose.yml][compose].

**This setup is not recommended for production usage! Please refer to
the official documentation if you are setting up a production oriented server.**

The docker compose will start elasticsearch and attach it to an external
docker network called *fluentd_stream_processing* and another internal network called *es*.

The *fluentd_stream_processing* network must be created separately.
Instructions on how to create it are found from [fluentd help](https://github.com/wirepas/tutorials/tree/master/fluentd).

The *es* network will be setup automatically for you by docker-compose.

Once you are sure that you have met the requirements, type

```bash
   docker-compose up -d
```

and elasticsearch will start inside a container and keep running until you explicitly stop it.

To view the status of your containers, you can use

```bash
   docker ps -a
```

If all went well, your containers should continue running and now you are ready to
communicate with elasticsearch over your host's **9200** port
(see ports directive in [docker-compose.yml][compose].

## KIBANA

Kibana is a plugin to visualize data stored in elasticsearch.
The [docker-compose.yml][compose] will also start
kibana and advertise its service at port **5601**.

To access Kibana point your browser to [localhost:5601](http://localhost:5601).

## Visualizing data in Kibana

Kibana works by indexing a particular tag that is present in elasticsearch.
In this example it is expected that you match your data against the index
defined with fluentd. Figure 1 shows an example of the discover feed where
you can search data for index app.ruuvi\*.

![kibana discover][kibana_discover]

**Figure 1 -** Kibana discover feed showing data for index app.ruuvi

Setting a index requires that you head to the kibana management and
create the index you desire, based on the \\&lt;tag>.\\&lt;record> of your choice.

Kibana will tell you if elasticsearch has data matching the index you are
trying to match.

If there is no data, you first need to ensure that you have data present
in such index.

[compose]: https://github.com/wirepas/tutorials/blob/master/elastic_search/docker-compose.yml

[es_guide]: https://www.elastic.co/guide/en/elastic-stack/7.1/index.html

[es_guide_docker]: https://www.elastic.co/guide/en/elasticsearch/reference/7.1/docker.html

[kibana_discover]: https://github.com/wirepas/tutorials/blob/master/elastic_search/img/kibana-discover.png
