#!/usr/bin/env python
# encoding: utf-8

"""
很多人也想将gevent和multiprocessing一起使用。最明显的挑战之一 就是multiprocessing提供的进程间通信默认不是协作式的。由于基于 multiprocessing.Connection的对象(例如Pipe)暴露了它们下面的 文件描述符(file descriptor)，gevent.socket.wait_read和wait_write 可以用来在直接读写之前协作式的等待ready-to-read/ready-to-write事件。


"""

import gevent
from multiprocessing import Process, Pipe
from gevent.socket import wait_read, wait_write

# To Process
a, b = Pipe()

# From Process
c, d = Pipe()

def relay():
    for i in xrange(10):
        msg = b.recv()
        c.send(msg + " in " + str(i))

def put_msg():
    for i in xrange(10):
        wait_write(a.fileno())
        a.send('hi')

def get_msg():
    for i in xrange(10):
        wait_read(d.fileno())
        print(d.recv())

if __name__ == '__main__':
    proc = Process(target=relay)
    proc.start()

    g1 = gevent.spawn(get_msg)
    g2 = gevent.spawn(put_msg)
    gevent.joinall([g1, g2], timeout=1)


"""
然而要注意，组合multiprocessing和gevent必定带来 依赖于操作系统(os-dependent)的缺陷，其中有：

在兼容POSIX的系统创建子进程(forking)之后， 在子进程的gevent的状态是不适定的(ill-posed)。
一个副作用就是， multiprocessing.Process创建之前的greenlet创建动作，会在父进程和子进程两 方都运行。


上例的put_msg()中的a.send()可能依然非协作式地阻塞调用的线程：一个 ready-to-write事件只保证写了一个byte。在尝试写完成之前底下的buffer可能是满的。

上面表示的基于wait_write()/wait_read()的方法在Windows上不工作 (IOError: 3 is not a socket (files are not supported))，因为Windows不能监视 pipe事件。

Python包gipc以大体上透明的方式在 兼容POSIX系统和Windows上克服了这些挑战。
它提供了gevent感知的基于 multiprocessing.Process的子进程和gevent基于pipe的协作式进程间通信。

"""
