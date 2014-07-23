#!/usr/bin/env python
# encoding: utf-8

"""
就像之前所提到的，greenlet具有确定性。在相同配置相同输入的情况下，它们总是 会产生相同的输出。下面就有例子，我们在multiprocessing的pool之间执行一系列的 任务，与在gevent的pool之间执行作比较。

TODO: what is this pool? imap_unordered?

------

即使gevent通常带有确定性，当开始与如socket或文件等外部服务交互时， 不确定性也可能溜进你的程序中。因此尽管gevent线程是一种“确定的并发”形式， 使用它仍然可能会遇到像使用POSIX线程或进程时遇到的那些问题。
涉及并发长期存在的问题就是竞争条件(race condition)。简单来说， 当两个并发线程/进程都依赖于某个共享资源同时都尝试去修改它的时候， 就会出现竞争条件。这会导致资源修改的结果状态依赖于时间和执行顺序。 这是个问题，我们一般会做很多努力尝试避免竞争条件， 因为它会导致整个程序行为变得不确定。
最好的办法是始终避免所有全局的状态。全局状态和导入时(import-time)副作用总是会 反咬你一口！
"""

import time

def echo(i):
    time.sleep(0.001)
    return i

# Non Deterministic Process Pool

from multiprocessing.pool import Pool

p = Pool(10)
run1 = [a for a in p.imap_unordered(echo, xrange(10))]
run2 = [a for a in p.imap_unordered(echo, xrange(10))]
run3 = [a for a in p.imap_unordered(echo, xrange(10))]
run4 = [a for a in p.imap_unordered(echo, xrange(10))]

print(run1 == run2 == run3 == run4)

# Deterministic Gevent Pool

from gevent.pool import Pool

p = Pool(10)
run1 = [a for a in p.imap_unordered(echo, xrange(10))]
run2 = [a for a in p.imap_unordered(echo, xrange(10))]
run3 = [a for a in p.imap_unordered(echo, xrange(10))]
run4 = [a for a in p.imap_unordered(echo, xrange(10))]

print(run1 == run2 == run3 == run4)
