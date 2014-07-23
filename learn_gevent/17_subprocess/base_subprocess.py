#!/usr/bin/env python
# encoding: utf-8

"""
自gevent 1.0起，gevent.subprocess，一个Python subprocess模块 的修补版本已经添加。它支持协作式的等待子进程。
"""

import gevent
from gevent.subprocess import Popen, PIPE

def cron():
    while True:
        print("cron")
        gevent.sleep(0.2)

g = gevent.spawn(cron)
sub = Popen(['sleep 1; uname'], stdout=PIPE, shell=True)
out, err = sub.communicate()
g.kill()

print(out.rstrip())
