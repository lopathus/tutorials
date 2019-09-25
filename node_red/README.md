# Node-RED

Node-RED is a flow-based programming tool, original developed by IBM's
Emerging Technology Services team and now a part of the JS Foundation.

In this folder you will find an example on how to build your own Node-RED
image and how to start it up. There is also an example flow which will allow
you to interface with a Wirepas Mesh network.

The flow will connect to the MQTT broker and decode the top layer
of the protocol buffer messages. Since the messages on the broker consist
of protocol buffers, the flow and images depends on the protocol buffer
files present in the [backend-apis repository](https://github.com/wirepas/backend-apis/tree/master/gateway_to_backend/protocol_buffers_files)

## Starting node-red

You can either pull the image built from our docker hub or build it yourself
using

```bash
    docker-compose up -d --build
```

If the build fails, please review the Dockerfile contents and ensure you have
the proto files in the correct build context (side by side with docker-compose.yml).

Open your browser and navigate to

```bash
    http://localhost:1880
```

You will be greeted by the example flow

![Main view][node_red_main_view]

## Configure your MQTT settings

Locate the MQTT block (identified with WM network) double click on it and
edit the server entry (click on the pencil symbol).

In the next dialog, edit *Server* and update it with the Wirepas' hosted
instance address or your own compliant MQTT broker.

![MQTT's block settings][node_red_dialog_mqtt]

On the *Security* tab, please set the username and password accordingly.

![MQTT's security settings][node_red_dialog_mqtt_security]

Once connected to the MQTT broker, WM-data will flow through Node-RED and
you will be able to customize the flow to your liking.

In the example flow, the payload is converted to JSON and if it matches
endpoints 238:238, it will decode the payload header sent by the
Wirepas Mesh positioning application.

[node_red_main_view]: https://github.com/wirepas/tutorials/blob/master/node_red/img/node-red-flow.png

[node_red_dialog_mqtt]: https://github.com/wirepas/tutorials/blob/master/node_red/img/node-red-dialog-mqtt.png

[node_red_dialog_mqtt_security]: https://github.com/wirepas/tutorials/blob/master/node_red/img/node-red-dialog-security.png
