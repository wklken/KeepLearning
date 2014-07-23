#!/usr/bin/env python
# encoding: utf-8


"""
当主程序(main program)收到一个SIGQUIT信号时，不能成功做yield操作的 Greenlet可能会令意外地挂起程序的执行。这导致了所谓的僵尸进程， 它需要在Python解释器之外被kill掉。

对此，一个通用的处理模式就是在主程序中监听SIGQUIT信号，在程序退出 调用gevent.shutdown。
"""

import gevent
import signal

def run_forever():
    gevent.sleep(1000)

if __name__ == '__main__':
    gevent.signal(signal.SIGQUIT, gevent.shutdown)
    thread = gevent.spawn(run_forever)
    thread.join()


"""
报没有shutdown模块? 具体是什么原因? 版本?
"""

