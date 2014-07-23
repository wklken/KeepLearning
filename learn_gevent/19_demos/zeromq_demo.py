#!/usr/bin/env python
# encoding: utf-8

"""
http://zeromq.org/

ZeroMQ 被它的作者描述为 “一个表现得像一个并发框架的socket库”。 它是一个非常强大的，为构建并发和分布式应用的消息传递层。

ZeroMQ提供了各种各样的socket原语。最简单的是请求-应答socket对 (Request-Response socket pair)。一个socket有两个方法send和recv， 两者一般都是阻塞操作。但是Travis Cline 的一个杰出的库弥补了这一点，这个库使用gevent.socket来以非阻塞的方式 轮询ZereMQ socket。通过命令：

pip install gevent-zeromq

你可以从PyPi安装gevent-zeremq。

"""

# Note: Remember to ``pip install pyzmq gevent_zeromq``
import gevent
from gevent_zeromq import zmq

# Global Context
context = zmq.Context()

def server():
    server_socket = context.socket(zmq.REQ)
    server_socket.bind("tcp://127.0.0.1:5000")

    for request in range(1,10):
        server_socket.send("Hello")
        print('Switched to Server for %s' % request)
        # Implicit context switch occurs here
        server_socket.recv()

def client():
    client_socket = context.socket(zmq.REP)
    client_socket.connect("tcp://127.0.0.1:5000")

    for request in range(1,10):

        client_socket.recv()
        print('Switched to Client for %s' % request)
        # Implicit context switch occurs here
        client_socket.send("World")

publisher = gevent.spawn(server)
client    = gevent.spawn(client)

gevent.joinall([publisher, client])
