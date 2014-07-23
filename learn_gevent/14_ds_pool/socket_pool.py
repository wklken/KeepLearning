#!/usr/bin/env python
# encoding: utf-8

"""
当构造gevent驱动的服务时，经常会将围绕一个池结构的整个服务作为中心。 一个例子就是在各个socket上轮询的类。
"""

from gevent.pool import Pool

class SocketPool(object):

    def __init__(self):
        self.pool = Pool(1000)
        self.pool.start()

    def listen(self, socket):
        while True:
            socket.recv()

    def add_handler(self, socket):
        if self.pool.full():
            raise Exception("At maximum pool size")
        else:
            self.pool.spawn(self.listen, socket)

    def shutdown(self):
        self.pool.kill()
