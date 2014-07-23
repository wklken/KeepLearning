
http://xlambda.com/gevent-tutorial/
http://sdiehl.github.io/gevent-tutorial/#introduction
http://www.gevent.org/contents.html


--------------------------------

examples

https://github.com/surfly/gevent/tree/master/examples

greenlets

在gevent中用到的主要模式是Greenlet, 它是以C扩展模块形式接入Python的轻量级协程。 Greenlet全部运行在主程序操作系统进程的内部，但它们被协作式地调度。

在任何时刻，只有一个协程在运行。

这与multiprocessing或threading等提供真正并行构造的库是不同的。 这些库轮转使用操作系统调度的进程和线程，是真正的并行。

搞明白greenlet是什么东西



gevent is a coroutine-based Python networking library that uses greenlet to provide a high-level synchronous API on top of the libev event loop.

Features include:

Fast event loop based on libev (epoll on Linux, kqueue on FreeBSD).
Lightweight execution units based on greenlet.
API that re-uses concepts from the Python standard library (for example there are Events and Queues).
Cooperative sockets with SSL support »
DNS queries performed through threadpool or c-ares.
Monkey patching utility to get 3rd party modules to become cooperative »




-----------------

    http://my.oschina.net/visualgui823/blog/36987

什么事greenlet
greenlet是轻量级的并行编程，而gevent呢，就是利用greenlet实现的基于协程的python的网络library

什么是协程?

而协程算是一种轻量级进程，但又不能叫进程，因为操作系统并不知道它的存在。什么意思呢，就是说，协程像是一种在程序级别来模拟系统级别的进程，由于是单进程，并且少了上下文切换，于是相对来说系统消耗很少，而且网上的各种测试也表明，协程确实拥有惊人的速度。并且在实现过程中，协程可以用以前同步思路的写法，而运行起来确是异步的，也确实很有意思。话说有一种说法就是说进化历程是多进程->多线程->异步->协程，暂且不论说的对不对，单从诸多赞誉来看，协程还是有必要理解一下的。

----------



linux 的 IO模型是什么样的? select? epoll?


