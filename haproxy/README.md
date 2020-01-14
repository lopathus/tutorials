# HAProxy

This folder contains an example on how to setup HAProxy for handling TLS handshakes and access a web service via client certificates.

## HAProxy configuration

The HAProxy receives its configuration through [haproxy.conf][haproxy.conf]. 
A full list of options is available from the 
[official haproxy documentation][haproxy.docs]

In this example, we are going to bind to a local port, eg, 5601, and listen in to public traffic on port 5681. The port 5681 is where we set the TLS handshake and provide access to connections with a valid certificate file.

```shell

    listen dashboard
      bind *:5681 ssl crt /etc/ssl/certs/bundle.pem  ca-file /etc/ssl/certs/ca.crt verify required  crl-file /etc/ssl/certs/crl.pem
      mode tcp
      server dashboard 127.0.0.1:5601 check
```

[haproxy.conf]: https://github.com/wirepas/tutorials/blob/master/haproxy/haproxy.conf

[haproxy.docs]: http://www.haproxy.org/#docs
