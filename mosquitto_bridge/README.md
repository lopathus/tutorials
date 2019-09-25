# Mosquitto bridge

Mosquitto is a MQTT broker which Wirepas often uses to test its MQTT interface.

The example in this repository builds on the
[official docker image provided by the eclipse foundation][dockerhub].

You will find a [Dockerfile][dockerfile]  and a configuration file
([mosquitto.conf][mosquitto_conf]).

The Dockerfile contains additional layers added to the official
image which expose certain build and run time parameters to help
you customize the MQTT broker. 

The [mosquitto.conf][mosquitto_conf] allows to customize the broker and
its properties are [documented under the official documentation][mosquitto_help]

## Bridge setup

This container is preconfigured to be bridge between gateway and WNT
backend MQTT broker.

Therefore user controls which topics will be sent to WNT
(Wirepas Network Tool) backend and which ones are consumed on this
broker and not sent forward to WNT broker. This example limits the
topics the bridge sends to WNT backend.

Mosquitto configuration file ([mosquitto.conf](mosquitto_bridge/mosquitto.conf) needs to be modified to
contain your WNT backend MQTT credential in order it be be able to
send the data to WNT backend.

Consider changing these lines:

-   address mybackendip:port

-   remote_username mymqttuser

-   remote_password mymqttpassword

The modifications takes effect when you run the broker.

## Running the broker

Navigate to this folder and run

```bash
   docker-compose up -d
```

The broker will be started in the background.

[dockerhub]: https://hub.docker.com/_/eclipse-mosquitto

[dockerfile]: https://github.com/wirepas/tutorials/blob/master/mosquitto_bridge/Dockerfile

[mosquitto_conf]: https://github.com/wirepas/tutorials/blob/master/mosquitto_bridge/mosquitto.conf

[mosquitto_help]: https://mosquitto.org/man/mosquitto-conf-5.html
