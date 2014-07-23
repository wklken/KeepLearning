#!/usr/bin/env python
# encoding: utf-8

# tornado 模块
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

# 从命令行中读取配置
from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

# Tornado的请求处理函数类。当处理一个请求时，Tornado将这个类实例化，并调用与HTTP请求方法所对应的方法
# 继承RequestHandler
class IndexHandler(tornado.web.RequestHandler):
    def get(self):
        # RequestHandler 的内建方法 第二个参数是默认值
        greeting = self.get_argument('greeting', 'Hello')
        # 以一个字符串作为函数的参数，并将其写入到HTTP响应中
        self.write(greeting + ', friendly user!')

if __name__ == '__main__':
    # 使用options解析命令行
    tornado.options.parse_command_line()

    # 创建app
    #参数handlers非常重要，
    #是一个元组组成的列表，其中每个元组的第一个元素是一个用于匹配的正则表达式，第二个元素是一个RequestHanlder类。
    #可以按你的需要指定任意多个
    app = tornado.web.Application(handlers=[(r"/", IndexHandler)])

    # 就就监听端口
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

# python hello.py --port=8000
# curl http://localhost:8000/?greeting=Salutations
