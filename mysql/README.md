# MySQL

This folder contains a simple example on how to start and customize a
MySQL database on top of docker.

We recommend that you visit the
[official MySQL dockerhub page for instructions][dockerhub]

The example in this folder allows you to setup a database with the properties
defined in the docker-compose.yml file.

On the building stage Docker will copy the contents of [sql][sql] to
MySQL image entrypoint. The scripts will execute upon the database
initialization.

To build and start the server type

```bash

    docker-compose build

    docker-compose up -d
```

[sql]: https://github.com/wirepas/tutorials/tree/master/mysql/sql

[dockerhub]: https://hub.docker.com/_/mysql
