# Tutorials

[![Build Status](https://travis-ci.com/wirepas/tutorials.svg?branch=master)](https://travis-ci.com/wirepas/tutorials)

This repository contains several examples on how to run several backend
services which are useful to interact with Wirepas Mesh technology
at a backend level.

In more detail this repository contains instructions on how to run:

-   [Mosquitto](https://github.com/wirepas/tutorials/tree/master/mosquitto): a MQTT broker  [homepage](https://mosquitto.org/);

-   [Fluentd](https://github.com/wirepas/tutorials/tree/master/fluentd): a stream processor [homepage](https://www.fluentd.org/);

-   [Elastic Search](https://github.com/wirepas/tutorials/tree/master/elastic_search): a search engine based on the Lucene library [homepage](https://www.elastic.co/products/elasticsearch);

-   [Kibana](https://github.com/wirepas/tutorials/tree/master/elastic_search): an open source data visualization plugin for Elasticsearch [homepage](https://www.elastic.co/products/kibana).

Under [cookbook](https://github.com/wirepas/tutorials/tree/master/cookbook)
you will find useful receipts on how to put several of these services together.

## Requirements

The examples in this repository require that your host has the following
dependencies:

-   Python (recommended > 3.6)

-   Pip or equivalent

-   Docker engine (any version compatible with compose 2.0)

-   Docker compose (latest available)

Ensure Python is installed by typing on a terminal

```bash
   python --version
```

If the command succeeds, you will be shown the current version of python installed on your system. In case it fails, please use
your distribution's package manager on how to download and install Python.

Afterwards, check if pip is installed by typying the command

```bash
   pip --version
```

If it fails to install please use your distribution's channel or follow the installation tips in [Pip's page](https://pip.pypa.io/en/stable/installing/).

To check if docker is installed type

```bash
   docker --version
```

If the command fails, please review the [official installation instructions](https://docs.docker.com/install/) on how to install Docker
on your host.

Similarly, check if docker-compose is installed by typying

```bash
   docker-compose --version
```

If the command fails install docker-compose with

```bash
   pip install --user docker-compose
```

After the installation, please ensure that your PATH variable contains the path where docker-compose is installed to:

```bash
   PATH=${PATH}:\~./local/bin
```

Add the instruction to your *.bashrc* file in order to preserve the path between terminal sessions.

## Docker builds

You can retrieve public builds from [our registry in Docker hub][dockerhub].

## License

Licensed under the Apache License, Version 2.0. See LICENSE for the full license text.

[dockerhub]: https://hub.docker.com/u/wirepas
