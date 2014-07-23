#!/usr/bin/env python
# encoding: utf-8

"""
超时类也可以用在上下文管理器(context manager)中, 也就是with语句内。


"""

import gevent
from gevent import Timeout

time_to_wait = 5 # seconds

class TooLong(Exception):
    pass

with Timeout(time_to_wait, TooLong):
    gevent.sleep(10)
