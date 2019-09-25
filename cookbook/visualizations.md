# Evaluation kit data visualization

The next sections will guide you on how to setup [Kibana](https://www.elastic.co/products/kibana),
[Fluentd](https://www.fluentd.org/) and [Node-Red](https://nodered.org/).

Figure 1 describes the architecture that we will result from this exercise
as well as the APIs used between components.

![cookbook visualization overview][wm_cookbook_viz_overview]

**Figure 1 -** Overview of the final service setup after going through this guide.

## Before you continue

The instructions assume that you will be making the installation on a Linux
host with all the [pre-requisites met](https://github.com/wirepas/tutorials).

The examples in this repository also work with Windows and MacOS. For
guidance on how to install and configure docker engine on Windows and MacOS,
please refer to the [official instructions](https://docs.docker.com/install/).

By following these instructions, docker compose will pull images from
Wirepas' Docker hub registry. If you *do not* wish this to happen, please
pass the build flag or command explicitly to the docker-compose utility, eg,

```bash
   docker-compose up -d --build
```

or

```bash
   docker-compose build
```

For your convenience, you can review and extend the
[helper script][wm_cookbook_viz_helper] which contains all
the steps in this guide. You will also find a [compose file][wm_cookbook_viz_compose]
that deploys all the services mentioned in this recipe.

If you use the composition file to setup the services, please review its
content and update the MQTT credentials accordingly. The setup procedure
using the composition file is as follows:

![cookbook visualization video][wm_cookbook_viz_video]

If you want to go step by step, please start by cloning this repository
into your home directory:

```bash
   git clone https://github.com/wirepas/tutorials.git  /home/${USER}/wirepas/tutorials
```

## Using Node-RED

In this example we will be using:

-   [Protocol buffer definitions for the WP-RM-128 interface](https://github.com/wirepas/backend-apis/tree/master/gateway_to_backend/protocol_buffers_files)

-   [Node-RED](https://nodered.org/)

-   [An example Node-RED flow](https://github.com/wirepas/tutorials/blob/master/node_red/wm-red-flow.json)

Change directory to:

```bash
   cd /home/${USER}/wirepas/tutorials/node_red
```

Where you will find in the [instructions on how to setup Node-RED on top of Docker](https://github.com/wirepas/tutorials/blob/master/node_red/README.md).

As packets arrive, the flow will decode the protocol buffer and expose common metrics. You can customize the flow further in order to decode any network payload or route data towards a service of your choice.

![Main view][node_red_main_view]

**Figure 2 -** Overview of the node red that will be available to you.

## Using Kibana

In this example we will be using:

-   [Python package to subscribe and decode MQTT traffic](https://github.com/wirepas/backend-client)

-   [Python wrapper for the WP-RM-128 protocol buffer interface](https://github.com/wirepas/backend-apis/tree/master/wrappers/python)

-   [Fluentd for gathering and inserting network data in elastic search](https://www.fluentd.org/)

-   [Elasticsearch and Kibana](https://www.elastic.co/)

In this example, we use a Python tool to decode incoming MQTT traffic and publish the decoded packets to fluentd, which inserts those in elasticsearch.
Kibana will serve as a visualization engine where you can create your own dashboard and search the incoming data (see Figure 1).

### Setting up fluentd, elasticsearch and kibana

Change directory to:

```bash
   cd /home/${USER}/wirepas/tutorials/fluentd
```

Read the [installation steps](https://github.com/wirepas/tutorials/tree/master/fluentd) and start the service.

Change directory again to

```bash
   cd /home/${USER}/wirepas/tutorials/elastic_search
```

Read the [installation steps](https://github.com/wirepas/tutorials/tree/master/elastic_search), **fulfill the requirements** and start the service.

Inspect the status of fluentd, kibana and elasticsearch using

```bash
   docker ps -a
```

If the containers are restarting, read the installation steps again. If
everything seems to be in order inspect the stdout of the containers with

```bash
   docker ps <container name>
```

<!-- Add gif of terminal status -->

Open your browser and navigate to <http://localhost:5601>. Kibana will finish loading and after a few minutes you will be able to see its interface.

### Setting up the backend client

Assuming all the services are up and running the last step is to get data on
kibana is to install and configure the backend client to push data to fluentd.

The [backend client](https://github.com/wirepas/backend-client) serves as a
decoder and a test framework where you can extend the existing interfaces to
develop your own test cases.

Start by cloning the backend client repository using:

```bash
   git clone https://github.com/wirepas/backend-client.git /home/${USER}/wirepas/backend-client
```

Review the [installation instructions](https://github.com/wirepas/backend-client/blob/master/README.md)
and see the [Dockerfile](https://github.com/wirepas/backend-client/blob/master/container/Dockerfile)
for guidance on meeting other host dependencies.

You will also need to create a settings file with all your credentials and location of your fluentd server.

Add your MQTT broker credentials supplied to you to the correct keys in the file, for example:

```yaml
   mqtt_hostname: <mqtt hostname or ip, eg, com.extwirepas.com>
   mqtt_username: <username>
   mqtt_password: <password>
   mqtt_port: 8883
```

Add the location of fluentd along with the tag and record you want to identify your index with, for example:

```yaml
   fluentd_hostname: <fluentd hostname or ip, eg, localhost>
   fluentd_record: ruuvi
   fluentd_tag: app
```

If you have installed the Python package locally, start the [*mqtt_viewer.py*](https://github.com/wirepas/backend-client/blob/master/examples/mqtt_viewer.py) example with:

```bash
   python examples/mqtt_viewer.py --settings .settings.yml
```

In case you are using a docker build please ensure your volume mount is correct.

The example decodes incoming messages according to the defined
[endpoint to message mapping](https://github.com/wirepas/backend-client/blob/master/wirepas_backend_client/messages/interface.py).

<!-- Add gif of terminal status -->

### Configuring Kibana's dashboard

Open your browser and navigate once again to Kibana's user interface in <http://localhost:5601>.

Once kibana finishes loading, navigate to Management on the top left menu and click on *Saved Objects > Import*.

![Kibana import dialog][kibana_import]

**Figure 3 -** Kibana management and import object section.

Click import on the right side menu and import the json file located at

```bash
   ${HOME}/wirepas/tutorials/elastic_search/dashboards/evk_ruuvi.json
```

Once the import is done, navigate to Dashboard on Kibana's left menu and click on *\[WM] Ruuvi Evk*.
The dashboard will display values regarding your device sensors as well as other network metrics.

![Kibana dashboard][kibana_dashboard]

**Figure 4 -** Dashboard for visualizing the Ruuvi EVK data

You can customize Kibana according to your needs and use the backend client
to develop your own test cases evaluation scripts.

An evaluation license will allow you to develop and build custom
applications for your devices.

<!-- Figures -->

[wm_cookbook_viz_overview]: https://github.com/wirepas/tutorials/blob/master/cookbook/img/cookbook-viz-overview.png

[wm_cookbook_viz_video]: https://github.com/wirepas/tutorials/blob/master/cookbook/img/visualization-quick-start.gif

[wm_cookbook_viz_helper]: https://github.com/wirepas/tutorials/blob/master/cookbook/visualizations_helper.sh

[wm_cookbook_viz_compose]: https://github.com/wirepas/tutorials/blob/master/cookbook/visualizations-docker-compose.yml

[kibana_dashboard]: https://github.com/wirepas/tutorials/blob/master/elastic_search/img/kibana-dashboard.png

[kibana_discover]: https://github.com/wirepas/tutorials/blob/master/elastic_search/img/kibana-discover.png

[kibana_import]: https://github.com/wirepas/tutorials/blob/master/elastic_search/img/kibana-import.png

[node_red_main_view]: https://github.com/wirepas/tutorials/blob/master/node_red/img/node-red-flow.png
