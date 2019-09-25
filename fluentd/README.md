# FLUENTD

Inside the conf folder, you will find the fluentd xml configuration. In
there you can apply filters, parsers and decide what to do with
incoming streams.

> tag.record ---->  MATCH  ---------> elasticsearch store
>
> source --------> FLUENTD ---------> OUTPUT

In this example we wil match any incoming tag and forward it to an
elastic search index with the same name.

Assuming your tag is *app* and your record *wirepas* this example will
create an index named *app.wirepas*.

In Kibana you can look this index with, eg, app.\*.

## Starting fluentd

In this example, the composition for fluentd will created a default network
called *fluentd_stream_processing* relies on an external network.

The network will be created by when you [start fluentd with][compose]

```bash
   docker-compose up -d
```

If the composition is successful, your fluentd container will be running
in the background and it will be able to process incoming streams on the
fluentd_stream_processing network or at the host's ports **24224**.

## Customizing fluentd

The example in this repository sources the configuration from
[fluent.conf][fluent_conf] which allows for defining the rules which you use to
match your inbound streams, which filters to apply and where to route
the outbound stream to.

The base for fluentd is inherited from the
[official docker image provided by fluentd](https://hub.docker.com/r/fluent/fluentd/).

Extra plugins are defined and installed within the [Dockerfile][dockerfile].

[dockerfile]: https://github.com/wirepas/tutorials/blob/master/fluentd/Dockerfile

[compose]: https://github.com/wirepas/tutorials/blob/master/fluentd/docker-compose.yml

[fluent_conf]: https://github.com/wirepas/tutorials/blob/master/fluentd/fluent.conf
