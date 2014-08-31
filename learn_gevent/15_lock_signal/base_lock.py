#!/usr/bin/env python
# encoding: utf-8

"""
信号量是一个允许greenlet相互合作，限制并发访问或运行的低层次的同步原语。

信号量有两个方法，acquire和release。

在信号量是否已经被 acquire或release，和拥有资源的数量之间不同，被称为此信号量的范围 (the bound of the semaphore)。

如果一个信号量的范围已经降低到0，它会 阻塞acquire操作直到另一个已经获得信号量的greenlet作出释放。

范围为1的信号量也称为锁(lock)。它向单个greenlet提供了互斥访问。 信号量和锁常常用来保证资源只在程序上下文被单次使用。



"""


from gevent import sleep
from gevent.pool import Pool
from gevent.coros import BoundedSemaphore

sem = BoundedSemaphore(2)

def worker1(n):
    sem.acquire()
    print('Worker %i acquired semaphore' % n)
    sleep(0)
    sem.release()
    print('Worker %i released semaphore' % n)

def worker2(n):
    with sem:
        print('Worker %i acquired semaphore' % n)
        sleep(0)
    print('Worker %i released semaphore' % n)

pool = Pool()
pool.map(worker1, xrange(0,2))
pool.map(worker2, xrange(3,6))
