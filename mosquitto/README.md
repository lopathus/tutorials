# Mosquitto

Mosquitto is a MQTT broker which Wirepas often uses to test its MQTT interface.

The example in this repository builds on the
[official docker image provided by the eclipse foundation](https://hub.docker.com/_/eclipse-mosquitto).

You will find a [Dockerfile](./Dockerfile)  and a configuration file ([mosquitto.conf](./mosquitto.conf)).

The Dockerfile contains additional layers added to the official image which expose certain build and run time parameters to help you customize the MQTT broker.

The [mosquitto.conf](./mosquitto.conf) allows to customize the broker and its properties.
All the setting are documented at <https://mosquitto.org/man/mosquitto-conf-5.html>.

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

Customize the broker settings present in the [Dockerfile](https://github.com/wirepas/tutorials/blob/master/mosquitto/Dockerfile)
and the [mosquitto.conf](https://github.com/wirepas/tutorials/blob/master/mosquitto/mosquitto.conf).

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

For your information, the mosquitto broker has several [tools to help you inspect its status](https://github.com/eclipse/mosquitto).

To complete the setup and configure the gateway to communicate with the MQTT broker you instantiated you will need the:

-   broker ip or hostname

-   broker secure port number

-   mosquitto username

-   mosquitto password
