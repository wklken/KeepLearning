#!/usr/bin/env python
# encoding: utf-8
"""
这个例子演示了一个根据多个购物者浏览器更新的零售商库存实时计数服务

这个应用提供一个带有"Add to Cart"按钮的HTML书籍细节页面，以及书籍剩余库存的计数。一个购物者将书籍添加到购物车之后，其他访问这个站点的访客可以立刻看到库存的减少。
"""

import tornado.web
import tornado.httpserver
import tornado.ioloop
import tornado.options
from uuid import uuid4

"""
既然长轮询连接已经关闭，购物车控制器必须删除已注册的回调函数列表中的回调函数。在这个例子中，我们只需要将回调函数列表替换为一个新的空列表。在请求处理中被调用并完成后删除已注册的回调函数十分重要，因为随后在调用回调函数时将在之前已关闭的连接上调用finish()，这会产生一个错误。
"""

class ShoppingCart(object):
    """
    维护我们的库存中商品的数量，以及把商品加入购物车的购物者列表
    """
    totalInventory = 10
    callbacks = []
    carts = {}

    def register(self, callback):
        self.callbacks.append(callback)

    def moveItemToCart(self, session):
        if session in self.carts:
            return

        self.carts[session] = True
        self.notifyCallbacks()

    def removeItemFromCart(self, session):
        if session not in self.carts:
            return

        del(self.carts[session])
        self.notifyCallbacks()

    #-----------------

    def notifyCallbacks(self):
        for c in self.callbacks:
            self.callbackHelper(c)

        self.callbacks = []

    def callbackHelper(self, callback):
        callback(self.getInventoryCount())

    def getInventoryCount(self):
        return self.totalInventory - len(self.carts)

#-----------------------------
class DetailHandler(tornado.web.RequestHandler):
    """
    DetailHandler用于渲染HTM

    DetailHandler为每个页面请求产生一个唯一标识符，在每次请求时提供库存数量，并向浏览器渲染index.html模板
    """
    def get(self):
        session = uuid4()
        count = self.application.shoppingCart.getInventoryCount()
        self.render("index.html", session=session, count=count)

class CartHandler(tornado.web.RequestHandler):
    """
    CartHandler用于提供操作购物车的接口

    CartHandler为浏览器提供了一个API来请求从访客的购物车中添加或删除物品。浏览器中运行的JavaScript提交POST请求来操作访客的购物车
    """
    def post(self):
        action = self.get_argument('action')
        session = self.get_argument('session')

        if not session:
            self.set_status(400)
            return

        if action == 'add':
            self.application.shoppingCart.moveItemToCart(session)
        elif action == 'remove':
            self.application.shoppingCart.removeItemFromCart(session)
        else:
            self.set_status(400)

class StatusHandler(tornado.web.RequestHandler):
    """
    StatusHandler用于查询全局库存变化的通知
    """

    @tornado.web.asynchronous
    def get(self):
        """
        注意的是get方法上面的@tornado.web.asynchronous装饰器。这使得Tornado在get方法返回时不会关闭连接。

        在这个方法中，我们只是注册了一个带有购物车控制器的回调函数

        我们只是注册了一个带有购物车控制器的回调函数 ,
        使用self.async_callback包住回调函数以确保回调函数中引发的异常不会使RequestHandler关闭连接
        """
        # 注册到 shoppingCart
        self.application.shoppingCart.register(self.async_callback(self.on_message))

    def on_message(self, count):
        """
        每当访客操作购物车，ShoppingCart控制器为每个已注册的回调函数调用on_message方法。这个方法将当前库存数量写入客户端并关闭连接。
        如果服务器不关闭连接的话，浏览器可能不会知道请求已经被完成，也不会通知脚本有过更新。
        """
        self.write('{"inventoryCount":"%d"}' % count)
        self.finish()

class Application(tornado.web.Application):
    def __init__(self):
        self.shoppingCart = ShoppingCart()

        handlers = [
            (r'/', DetailHandler),
            (r'/cart', CartHandler),
            (r'/cart/status', StatusHandler)
        ]

        settings = {
            'template_path': 'templates',
            'static_path': 'static'
        }

        tornado.web.Application.__init__(self, handlers, **settings)

if __name__ == '__main__':
    tornado.options.parse_command_line()

    app = Application()
    server = tornado.httpserver.HTTPServer(app)
    server.listen(8000)
    tornado.ioloop.IOLoop.instance().start()


