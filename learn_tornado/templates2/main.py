#!/usr/bin/env python
# encoding: utf-8

import os.path
import random

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

class IndexHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')

class MungedPageHandler(tornado.web.RequestHandler):
    def map_by_first_letter(self, text):
        mapped = dict()
        for line in text.split('\r\n'):
            for word in [x for x in line.split(' ') if len(x) > 0]:
                if word[0] not in mapped: mapped[word[0]] = []
                mapped[word[0]].append(word)
        return mapped

    def post(self):
        source_text = self.get_argument('source')
        text_to_change = self.get_argument('change')
        source_map = self.map_by_first_letter(source_text)
        change_lines = text_to_change.split('\r\n')
        # 函数可以直接作为参数, 传递到模板, 模板直接调用
        self.render('munged.html', source_map=source_map, change_lines=change_lines,
                choice=random.choice)

if __name__ == '__main__':
    tornado.options.parse_command_line()

    # static path
    """
    Tornado模板模块提供了一个叫作static_url的函数来生成static目录下文件的URL。让我们来看看在index.html中static_url的调用的示例代码：

    <link rel="stylesheet" href="{{ static_url("style.css") }}">

    其一，static_url函数创建了一个基于文件内容的hash值，并将其添加到URL末尾（查询字符串的参数v）。
          这个hash值确保浏览器总是加载一个文件的最新版而不是之前的缓存版本。
          无论是在你应用的开发阶段，还是在部署到生产环境使用时，都非常有用，因为你的用户不必再为了看到你的静态内容而清除浏览器缓存了。
    另一个好处是你可以改变你应用URL的结构，而不需要改变模板中的代码
    """
    app = tornado.web.Application(
        handlers=[(r'/', IndexHandler), (r'/poem', MungedPageHandler)],
        template_path=os.path.join(os.path.dirname(__file__), "templates"),
        # 你可以通过向Application类的构造函数传递一个名为static_path的参数来告诉Tornado从文件系统的一个特定位置提供静态文件
        static_path=os.path.join(os.path.dirname(__file__), "static"),
        debug=True
    )
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

