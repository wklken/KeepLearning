#!/usr/bin/env python
# encoding: utf-8

"""
404 Not Found
Tornado会在HTTP请求的路径无法匹配任何RequestHandler类相对应的模式时返回404（Not Found）响应码。

400 Bad Request
如果你调用了一个没有默认值的get_argument函数，并且没有发现给定名称的参数，Tornado将自动返回一个400（Bad Request）响应码。

405 Method Not Allowed
如果传入的请求使用了RequestHandler中没有定义的HTTP方法（比如，一个POST请求，但是处理函数中只有定义了get方法），Tornado将返回一个405（Methos Not Allowed）响应码。

500 Internal Server Error
当程序遇到任何不能让其退出的错误时，Tornado将返回500（Internal Server Error）响应码。你代码中任何没有捕获的异常也会导致500响应码。

200 OK
如果响应成功，并且没有其他返回码被设置，Tornado将默认返回一个200（OK）响应码。

当上述任何一种错误发生时，Tornado将默认向客户端发送一个包含状态码和错误信息的简短片段。如果你想使用自己的方法代替默认的错误响应，你可以重写write_error方法在你的RequestHandler类中

"""

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

class IndexHandler(tornado.web.RequestHandler):
    def get(self):
        greeting = self.get_argument('greeting', 'Hello')
        self.write(greeting + ', friendly user!')
    # 重写报错方法
    def write_error(self, status_code, **kwargs):
        self.write("Gosh darnit, user! You caused a %d error." % status_code)

if __name__ == "__main__":
    tornado.options.parse_command_line()
    app = tornado.web.Application(handlers=[(r"/", IndexHandler)])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

#curl -d foo=bar http://localhost:8000/

