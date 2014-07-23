#!/usr/bin/env python
# encoding: utf-8

"""
在gevent里面，上下文切换是通过yielding来完成的. 在下面的例子里， 我们有两个上下文，通过调用gevent.sleep(0)，它们各自yield向对方。

完成切换

TODO: 切换的机制
"""

import gevent

def foo():
    print('Running in foo')
    gevent.sleep(0)
    print('Explicit context switch to foo again')

def bar():
    print('Explicit context to bar')
    gevent.sleep(0)
    print('Implicit context switch back to bar')

gevent.joinall([
    gevent.spawn(foo),
    gevent.spawn(bar),
])


