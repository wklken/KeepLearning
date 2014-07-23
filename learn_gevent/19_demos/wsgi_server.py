#!/usr/bin/env python
# encoding: utf-8


Gevent为HTTP内容服务提供了两种WSGI server。从今以后就称为 wsgi和pywsgi：

gevent.wsgi.WSGIServer
gevent.pywsgi.WSGIServer
在1.0.x之前更早期的版本里，gevent使用libevent而不是libev。 Libevent包含了一个快速HTTP server，它被用在gevent的wsgi server。

在gevent 1.0.x版本，没有包括http server了。作为替代，gevent.wsgi 现在是纯Python server gevent.pywsgi的一个别名。


