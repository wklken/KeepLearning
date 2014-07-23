#!/usr/bin/env python
# encoding: utf-8

import textwrap

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

class ReverseHandler(tornado.web.RequestHandler):
    # get方法包含正则匹配中第一个分组的数据
    def get(self, input):
        self.write(input[::-1])

class WrapHandler(tornado.web.RequestHandler):
    # post请求
    def post(self):
        #Tornado可以解析URLencoded和multipart结构的POST请求
        text = self.get_argument('text')
        width = self.get_argument('width', 40)
        self.write(textwrap.fill(text, int(width)))


# more about http ===============================
def retrieve_from_db(widget_id):
    pass
def save_to_db(widget):
    pass
# matched with (r"/widget/(\d+)", WidgetHandler)
class WidgetHandler(tornado.web.RequestHandler):
    def get(self, widget_id):
        widget = retrieve_from_db(widget_id)
        self.write(widget.serialize())

    def post(self, widget_id):
        widget = retrieve_from_db(widget_id)
        widget['foo'] = self.get_argument('foo')
        save_to_db(widget)

# matched with (r"/frob/(\d+)", FrobHandler)
class FrobHandler(tornado.web.RequestHandler):
    def head(self, frob_id):
        frob = retrieve_from_db(frob_id)
        if frob is not None:
            # 设置http状态码
            self.set_status(200)
        else:
            self.set_status(404)
    def get(self, frob_id):
        frob = retrieve_from_db(frob_id)
        self.write(frob.serialize())
# more about http ===============================


if __name__ == "__main__":
    tornado.options.parse_command_line()
    # route
    app = tornado.web.Application(
        handlers=[
            (r"/reverse/(\w+)", ReverseHandler),
            (r"/wrap", WrapHandler)
        ]
    )

    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

# curl http://localhost:8000/reverse/stressed
# curl http://localhost:8000/wrap -d text=Lorem+ipsum+dolor+sit+amet,+consectetuer+adipiscing+elit.
