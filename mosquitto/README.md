# Mosquitto

Mosquitto is a MQTT broker which Wirepas often uses to test its MQTT interface.

The example in this repository builds on the
[official docker image provided by the eclipse foundation][mosquitto_dockerhub].

You will find a [Dockerfile][here_dockerfile]  and a configuration file ([mosquitto.conf][here_mqqt_conf]).

The Dockerfile contains additional layers added to the official image which expose certain build and run time parameters to help you customize the MQTT broker.

The [mosquitto.conf][here_mqqt_conf] allows to customize the broker and its properties.
All the setting are documented in [mosquitto's documention][mosquitto_docs].

## Setting up your own MQTT broker

This section guides you on how to setup a MQTT broker.

If you have not done it yet, start by cloning the repository with:

```bash
   git clone https://github.com/wirepas/tutorials.git  /home/${USER}/wirepas/tutorials
```

Change directory into the mosquitto folder

```bash
   cd tutorials/mosquitto
```

Customize the broker settings present in the [Dockerfile][here_dockerfile]
and the [mosquitto.conf][here_mqqt_conf].

Start the broker with

```bash
   docker-compose up -d
```

Validate that the broker is running by inspecting the container status

```bash
   docker-compose ps
```

or

```bash
   docker ps -a
```

After these steps your message broker is ready to serve publishers and subscribers according to your credentials.

For your information, the mosquitto broker has several [tools to help you inspect its status][mosquitto_repo].

To complete the setup and configure the gateway to communicate with the MQTT broker you instantiated you will need the:

-   broker ip or hostname

-   broker secure port number

-   mosquitto username

-   mosquitto password


[mosquitto_repo]: https://github.com/eclipse/mosquitto

[mosquitto_dockerhub]: https://hub.docker.com/_/eclipse-mosquitto 

[mosquitto_docs]: https://mosquitto.org/man/mosquitto-conf-5.html

[here_mqqt_conf]: https://github.com/wirepas/tutorials/blob/master/mosquitto/mosquitto.conf.template 

[here_dockerfile]: https://github.com/wirepas/tutorials/blob/master/mosquitto/Dockerfile
