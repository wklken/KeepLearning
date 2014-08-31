#!/usr/bin/env python
# encoding: utf-8

"""
当我们在受限于网络或IO的函数中使用gevent，这些函数会被协作式的调度， gevent的真正能力会得到发挥。

Gevent处理了所有的细节， 来保证你的网络库会在可能的时候，隐式交出greenlet上下文的执行权。
这样的一种用法是如何强大，怎么强调都不为过。或者我们举些例子来详述。

下面例子中的select()函数通常是一个在各种文件描述符上轮询的阻塞调用。


TODO: select? 作用?

http://www.gevent.org/gevent.select.html

"""

import time
import gevent
from gevent import select

start = time.time()
tic = lambda: 'at %1.1f seconds' % (time.time() - start)

def gr1():
    # Busy waits for a second, but we don't want to stick around...
    print('Started Polling: %s' % tic())

    # gevent.select.select(rlist, wlist, xlist, timeout=None)
    select.select([], [], [], 2)
    print('Ended Polling: %s' % tic())

def gr2():
    # Busy waits for a second, but we don't want to stick around...
    print('Started Polling: %s' % tic())

    # gevent.select.select(rlist, wlist, xlist, timeout=None)
    select.select([], [], [], 2)
    print('Ended Polling: %s' % tic())

def gr3():
    print("Hey lets do some stuff while the greenlets poll, %s" % tic())
    gevent.sleep(1)

gevent.joinall([
    gevent.spawn(gr1),
    gevent.spawn(gr2),
    gevent.spawn(gr3),
])
