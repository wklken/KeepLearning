#!/usr/bin/env python
# encoding: utf-8


"""
Gevent也允许你指定局部于greenlet上下文的数据。 在内部，它被实现为以greenlet的getcurrent()为键， 在一个私有命名空间寻址的全局查找。


"""

import gevent
from gevent.local import local

stash = local()

def f1():
    stash.x = 1
    print(stash.x)

def f2():
    stash.y = 2
    print(stash.y)

    try:
        stash.x
    except AttributeError:
        print("x is not local to f2")

g1 = gevent.spawn(f1)
g2 = gevent.spawn(f2)

gevent.joinall([g1, g2])
