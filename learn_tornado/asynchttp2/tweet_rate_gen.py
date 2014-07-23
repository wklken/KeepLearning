#!/usr/bin/env python
# encoding: utf-8

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import tornado.httpclient
import tornado.gen

import urllib
import json
import datetime
import time

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

# tornado 2.1 才有
# i like that
# more about gen http://www.tornadoweb.org/en/stable/gen.html
class IndexHandler(tornado.web.RequestHandler):
    # 注意这里
    # 记住@tornado.gen.engine装饰器的使用需要刚好在get方法的定义之前；
    # 这将提醒Tornado这个方法将使用tornado.gen.Task类。tornado.gen模块还哟一些其他类和函数可以方便Tornado的异步编程
    @tornado.web.asynchronous
    @tornado.gen.engine
    def get(self):
        query = self.get_argument('q')
        client = tornado.httpclient.AsyncHTTPClient()

        # 使用Python的yield关键字以及tornado.gen.Task对象的一个实例，将我们想要的调用和传给该调用函数的参数传递给那个函数
        # yield的使用返回程序对Tornado的控制，允许在HTTP请求进行中执行其他任务
        response = yield tornado.gen.Task(client.fetch,
                "http://search.twitter.com/search.json?" + \
                urllib.urlencode({"q": query, "result_type": "recent", "rpp": 100}))
        # 当HTTP请求完成时，RequestHandler方法在其停止的地方恢复。这种构建的美在于它在请求处理程序中返回HTTP响应，而不是回调函数中
        # 代码更易理解：所有请求相关的逻辑位于同一个位置
        # 而HTTP请求依然是异步执行的，所以我们使用tornado.gen可以达到和使用回调函数的异步请求版本相同的性能
        body = json.loads(response.body)
        result_count = len(body['results'])
        now = datetime.datetime.utcnow()
        raw_oldest_tweet_at = body['results'][-1]['created_at']
        oldest_tweet_at = datetime.datetime.strptime(raw_oldest_tweet_at,
                "%a, %d %b %Y %H:%M:%S +0000")
        seconds_diff = time.mktime(now.timetuple()) - \
                time.mktime(oldest_tweet_at.timetuple())
        tweets_per_second = float(result_count) / seconds_diff
        self.write("""
<div style="text-align: center">
    <div style="font-size: 72px">%s</div>
    <div style="font-size: 144px">%.02f</div>
    <div style="font-size: 24px">tweets per second</div>
</div>""" % (query, tweets_per_second))
        self.finish()

if __name__ == "__main__":
    tornado.options.parse_command_line()
    app = tornado.web.Application(handlers=[(r"/", IndexHandler)])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()
