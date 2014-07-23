#!/usr/bin/env python
# encoding: utf-8


"""
我们现在来到gevent的死角了. 在此之前，我已经避免提到猴子补丁(monkey patching) 以尝试使gevent这个强大的协程模型变得生动有趣，但现在到了讨论猴子补丁的黑色艺术 的时候了。你之前可能注意到我们提到了monkey.patch_socket()这个命令，这个 纯粹副作用命令是用来改变标准socket库的。
"""

import socket
print(socket.socket)

print("After monkey patch")
from gevent import monkey
monkey.patch_socket()
print(socket.socket)

import select
print(select.select)
monkey.patch_select()
print("After monkey patch")
print(select.select)

"""
Python的运行环境允许我们在运行时修改大部分的对象，包括模块，类甚至函数。 这是个一般说来令人惊奇的坏主意，因为它创造了“隐式的副作用”，如果出现问题 它很多时候是极难调试的。虽然如此，在极端情况下当一个库需要修改Python本身 的基础行为的时候，猴子补丁就派上用场了。在这种情况下，gevent能够 修改标准库里面大部分的阻塞式系统调用，包括socket、ssl、threading和 select等模块，而变为协作式运行。

例如，Redis的python绑定一般使用常规的tcp socket来与redis-server实例通信。 通过简单地调用gevent.monkey.patch_all()，可以使得redis的绑定协作式的调度 请求，与gevent栈的其它部分一起工作。

这让我们可以将一般不能与gevent共同工作的库结合起来，而不用写哪怕一行代码。 虽然猴子补丁仍然是邪恶的(evil)，但在这种情况下它是“有用的邪恶(useful evil)”。
"""
