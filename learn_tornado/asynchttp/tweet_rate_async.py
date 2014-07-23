#!/usr/bin/env python
# encoding: utf-8


import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import tornado.httpclient

import urllib
import json
import datetime
import time

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

class IndexHandler(tornado.web.RequestHandler):
    # 注意的是@tornado.web.asynchronous装饰器的使用（在get方法的定义之前）以及在回调方法结尾处调用的self.finish()
    # Tornado默认在函数处理返回时关闭客户端的连接。
    # 在通常情况下，这正是你想要的。
    # 但是当我们处理一个需要回调函数的异步请求时，我们需要连接保持开启状态直到回调函数执行完毕。
    # 你可以在你想改变其行为的方法上面使用@tornado.web.asynchronous装饰器来告诉Tornado保持连接开启
    @tornado.web.asynchronous
    def get(self):
        query = self.get_argument('q')
        # 异步http
        client = tornado.httpclient.AsyncHTTPClient()
        # fetch并不返回调用结果, 而是指向一个callback参数
        # callback在http请求完成时被调用, 并使用HTTPResponse作为其参数
        client.fetch("http://search.twitter.com/search.json?" + \
                urllib.urlencode({"q": query, "result_type": "recent", "rpp": 100}),
                callback=self.on_response)

    # 回调函数
    def on_response(self, response):
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
</div>""" % (self.get_argument('q'), tweets_per_second))
        # 回调结束
        # 记住当你使用@tornado.web.asynchonous装饰器时，Tornado永远不会自己关闭连接。
        # 你必须在你的RequestHandler对象中调用finish方法来显式地告诉Tornado关闭连接。
        # （否则，请求将可能挂起，浏览器可能不会显示我们已经发送给客户端的数据。）
        self.finish()

if __name__ == "__main__":
    tornado.options.parse_command_line()
    app = tornado.web.Application(handlers=[(r"/", IndexHandler)])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

