#!/usr/bin/env python
# encoding: utf-8

"""
除使用基本的Greenlet类之外，你也可以子类化Greenlet类，重载它的_run方法
"""

import gevent
from gevent import Greenlet

class MyGreenlet(Greenlet):

    def __init__(self, message, n):
        Greenlet.__init__(self)
        self.message = message
        self.n = n

    def _run(self):
        print(self.message)
        gevent.sleep(self.n)

g = MyGreenlet("Hi there!", 3)
g.start()
g.join()
