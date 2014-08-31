#!/usr/bin/env python
# encoding: utf-8


"""
组(group)是一个运行中greenlet的集合，集合中的greenlet像一个组一样 会被共同管理和调度。
它也兼饰了像Python的multiprocessing库那样的 平行调度器的角色。
"""

import gevent
from gevent.pool import Group

def talk(msg):
    for i in xrange(3):
        print(msg)

g1 = gevent.spawn(talk, 'bar')

g2 = gevent.spawn(talk, 'foo')

g3 = gevent.spawn(talk, 'fizz')

group = Group()
group.add(g1)
group.add(g2)
group.join()

print "abc"

group.add(g3)
group.join()
