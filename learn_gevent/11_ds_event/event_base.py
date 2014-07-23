#!/usr/bin/env python
# encoding: utf-8

"""
事件(event)是一个在Greenlet之间异步通信的形式
"""

import gevent
from gevent.event import Event

'''
Illustrates the use of events
'''

evt = Event()

def setter():
    '''After 3 seconds, wake all threads waiting on the value of evt'''
    print('A: Hey wait for me, I have to do something')
    gevent.sleep(3)
    print("Ok, I'm done")
    evt.set()

def waiter():
    '''After 3 seconds the get call will unblock'''
    print("I'll wait for you")
    # 阻塞
    evt.wait()  # blocking
    print("It's about time")

def main():
    gevent.joinall([
        gevent.spawn(setter),
        gevent.spawn(waiter),
        gevent.spawn(waiter),
        gevent.spawn(waiter),
        gevent.spawn(waiter),
        gevent.spawn(waiter)
    ])

if __name__ == '__main__': main()


