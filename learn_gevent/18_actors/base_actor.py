#!/usr/bin/env python
# encoding: utf-8

"""
actor模型是一个由于Erlang变得普及的更高层的并发模型。

简单的说它的主要思想就是许多个独立的Actor，每个Actor有一个可以从 其它Actor接收消息的收件箱。
Actor内部的主循环遍历它收到的消息，并 根据它期望的行为来采取行动。

Gevent没有原生的Actor类型，但在一个子类化的Greenlet内使用队列， 我们可以定义一个非常简单的。
"""

import gevent
from gevent.queue import Queue

class Actor(gevent.Greenlet):

    def __init__(self):
        self.inbox = Queue()
        gevent.Greenlet.__init__(self)

    def receive(self, message):
        """
        Define in your subclass.
        """
        raise NotImplemented()

    def _run(self):
        self.running = True

        while self.running:
            message = self.inbox.get()
            self.receive(message)

