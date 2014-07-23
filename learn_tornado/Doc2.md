Tornado官方文档

http://www.tornadoweb.org/en/stable/

可扩展的非阻塞式 web 服务器及其相关工具的开源版本

它是非阻塞式服务器，而且速度相当快。得利于其 非阻塞的方式和对 epoll 的运用，

------------------

install

sudo easy_install setuptools pycurl
brew install tornado

ubuntu
sudo apt-get install python-pycurl

使用 pip 或 easy_install 安装的 Tornado 并没有包含源代码中的 demo 程序


----------------
helloworld

import tornado.ioloop
import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")

application = tornado.web.Application([
    (r"/", MainHandler),
])

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()

---------------

模块索引
最重要的一个模块是web， 它就是包含了 Tornado 的大部分主要功能的 Web 框架。其它的模块都是工具性质的， 以便让 web 模块更加有用 后面的 Tornado 攻略 详细讲解了 web 模块的使用方法。

主要模块
web - FriendFeed 使用的基础 Web 框架，包含了 Tornado 的大多数重要的功能
escape - XHTML, JSON, URL 的编码/解码方法
database - 对 MySQLdb 的简单封装，使其更容易使用
template - 基于 Python 的 web 模板系统
httpclient - 非阻塞式 HTTP 客户端，它被设计用来和 web 及 httpserver 协同工作
auth - 第三方认证的实现（包括 Google OpenID/OAuth、Facebook Platform、Yahoo BBAuth、FriendFeed OpenID/OAuth、Twitter OAuth）
locale - 针对本地化和翻译的支持
options - 命令行和配置文件解析工具，针对服务器环境做了优化

底层模块
httpserver - 服务于 web 模块的一个非常简单的 HTTP 服务器的实现
iostream - 对非阻塞式的 socket 的简单封装，以方便常用读写操作
ioloop - 核心的 I/O 循环

---------------

handle url

    class MainHandler(tornado.web.RequestHandler):
        def get(self):
            self.write("You requested the main page")

    class StoryHandler(tornado.web.RequestHandler):
        def get(self, story_id):
            self.write("You requested the story " + story_id)

    application = tornado.web.Application([
        (r"/", MainHandler),
        (r"/story/([0-9]+)", StoryHandler),
    ])

arguments

    class MainHandler(tornado.web.RequestHandler):
        def get(self):
            self.write('<html><body><form action="/" method="post">'
                    '<input type="text" name="message">'
                    '<input type="submit" value="Submit">'
                    '</form></body></html>')

        def post(self):
            self.set_header("Content-Type", "text/plain")
            self.write("You wrote " + self.get_argument("message"))

上传文件

上传的文件可以通过 self.request.files 访问到

status code

    if not self.user_is_logged_in():
        raise tornado.web.HTTPError(403)

请求处理程序可以通过 self.request 访问到代表当前请求的对象。该 HTTPRequest 对象包含了一些有用的属性，包括：

    arguments - 所有的 GET 或 POST 的参数
    files - 所有通过 multipart/form-data POST 请求上传的文件
    path - 请求的路径（ ? 之前的所有内容）
    headers - 请求的开头信息

------------------------

重写 RequestHandler 的方法函数

除了 get()/post()等以外，RequestHandler 中的一些别的方法函数，这都是 一些空函数，它们存在的目的是在必要时在子类中重新定义其内容。对于一个请求的处理 的代码调用次序如下：

    程序为每一个请求创建一个 RequestHandler 对象
    程序调用 initialize() 函数，这个函数的参数是 Application 配置中的关键字 参数定义。（initialize 方法是 Tornado 1.1 中新添加的，旧版本中你需要 重写 __init__ 以达到同样的目的） initialize 方法一般只是把传入的参数存 到成员变量中，而不会产生一些输出或者调用像 send_error 之类的方法。
    程序调用 prepare()。无论使用了哪种 HTTP 方法，prepare 都会被调用到，因此 这个方法通常会被定义在一个基类中，然后在子类中重用。prepare可以产生输出 信息。如果它调用了finish（或send_error` 等函数），那么整个处理流程 就此结束。
    程序调用某个 HTTP 方法：例如 get()、post()、put() 等。如果 URL 的正则表达式模式中有分组匹配，那么相关匹配会作为参数传入方法。
    下面是一个示范 initialize() 方法的例子：

    class ProfileHandler(RequestHandler):
        def initialize(self, database):
            self.database = database

        def get(self, username):
            ...

    app = Application([
        (r'/user/(.*)', ProfileHandler, dict(database=database)),
        ])
其它设计用来被复写的方法有：

get_error_html(self, status_code, exception=None, **kwargs) - 以字符串的形式 返回 HTML，以供错误页面使用。
get_current_user(self) - 查看下面的用户认证一节
get_user_locale(self) - 返回 locale 对象，以供当前用户使用。
get_login_url(self) - 返回登录网址，以供 @authenticated 装饰器使用（默认位置 在 Application 设置中）
get_template_path(self) - 返回模板文件的路径（默认是 Application 中的设置）

------------------------

重定向(redirect)

Tornado 中的重定向有两种主要方法：self.redirect，或者使用 RedirectHandler。

你可以在使用 RequestHandler （例如 get）的方法中使用 self.redirect，将用户 重定向到别的地方。另外还有一个可选参数 permanent，你可以用它指定这次操作为永久性重定向。

该参数会激发一个 301 Moved Permanently HTTP 状态，这在某些情况下是有用的， 例如，你要将页面的原始链接重定向时，这种方式会更有利于搜索引擎优化（SEO）。

permanent 的默认值是 False，这是为了适用于常见的操作，例如用户端在成功发送 POST 请求 以后的重定向。

    self.redirect('/some-canonical-page', permanent=True)

RedirectHandler 会在你初始化 Application 时自动生成。

例如本站的下载 URL，由较短的 URL 重定向到较长的 URL 的方式是这样的：

    application = tornado.wsgi.WSGIApplication([
        (r"/([a-z]*)", ContentHandler),
        (r"/static/tornado-0.2.tar.gz", tornado.web.RedirectHandler,
        dict(url="http://github.com/downloads/facebook/tornado/tornado-0.2.tar.gz")),
    ], **settings)

RedirectHandler 的默认状态码是 301 Moved Permanently，不过如果你想使用 302 Found 状态码，你需要将 permanent 设置为 False。

    application = tornado.wsgi.WSGIApplication([
        (r"/foo", tornado.web.RedirectHandler, {"url":"/bar", "permanent":False}), ], **settings)

注意，在 self.redirect 和 RedirectHandler 中，permanent 的默认值是不同的。 这样做是有一定道理的，self.redirect 通常会被用在自定义方法中，是由逻辑事件触发 的（例如环境变更、用户认证、以及表单提交）。而 RedirectHandler 是在每次匹配到请求 URL 时被触发。

-----------------

模板
你可以在 Tornado 中使用任何一种 Python 支持的模板语言。但是相较于其它模板而言， Tornado 自带的模板系统速度更快，并且也更灵活。

下面列表中 的对象或方法在使用 RequestHandler.render 或者 render_string 时才存在的

    escape: tornado.escape.xhtml_escape 的別名
    xhtml_escape: tornado.escape.xhtml_escape 的別名
    url_escape: tornado.escape.url_escape 的別名
    json_encode: tornado.escape.json_encode 的別名
    squeeze: tornado.escape.squeeze 的別名
    linkify: tornado.escape.linkify 的別名
    datetime: Python 的 datetime 模组
    handler: 当前的 RequestHandler 对象
    request: handler.request 的別名
    current_user: handler.current_user 的別名
    locale: handler.locale 的別名
    _: handler.locale.translate 的別名
    static_url: for handler.static_url 的別名
    xsrf_form_html: handler.xsrf_form_html 的別名
    reverse_url: Application.reverse_url 的別名
    Application 设置中 ui_methods 和 ui_modules 下面的所有项目
    任何传递给 render 或者 render_string 的关键字参数

template文档 https://github.com/tornadoweb/tornado/blob/master/tornado/template.py

-----------------

cookie

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        if not self.get_cookie("mycookie"):
            self.set_cookie("mycookie", "myvalue")
            self.write("Your cookie was not set yet!")
        else:
            self.write("Your cookie was set!")

对 cookie 作签名以防止伪造。Tornado 通过 set_secure_cookie 和 get_secure_cookie 方法直接支持了这种功能

    application = tornado.web.Application([
        (r"/", MainHandler),
    ], cookie_secret="61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=")

    class MainHandler(tornado.web.RequestHandler):
        def get(self):
            if not self.get_secure_cookie("mycookie"):
                self.set_secure_cookie("mycookie", "myvalue")
                self.write("Your cookie was not set yet!")
            else:
                self.write("Your cookie was set!")

----------------

用户认证

当前已经认证的用户信息被保存在每一个请求处理器的 self.current_user 当中， 同时在模板的 current_user 中也是。默认情况下，current_user 为 None。

要在应用程序实现用户认证的功能，你需要复写请求处理中 get_current_user() 这 个方法，在其中判定当前用户的状态，比如通过 cookie。

    class BaseHandler(tornado.web.RequestHandler):
        def get_current_user(self):
            return self.get_secure_cookie("user")

    class MainHandler(BaseHandler):
        def get(self):
            if not self.current_user:
                self.redirect("/login")
                return
            name = tornado.escape.xhtml_escape(self.current_user)
            self.write("Hello, " + name)

    class LoginHandler(BaseHandler):
        def get(self):
            self.write('<html><body><form action="/login" method="post">'
                    'Name: <input type="text" name="name">'
                    '<input type="submit" value="Sign in">'
                    '</form></body></html>')

        def post(self):
            self.set_secure_cookie("user", self.get_argument("name"))
            self.redirect("/")

    application = tornado.web.Application([
        (r"/", MainHandler),
        (r"/login", LoginHandler),
    ], cookie_secret="61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=")

对于那些必须要求用户登陆的操作，可以使用装饰器 tornado.web.authenticated。 如果一个方法套上了这个装饰器，但是当前用户并没有登陆的话，页面会被重定向到 login_url（应用配置中的一个选项），上面的例子可以被改写成：

    class MainHandler(BaseHandler):
        @tornado.web.authenticated
        def get(self):
            name = tornado.escape.xhtml_escape(self.current_user)
            self.write("Hello, " + name)

    settings = {
        "cookie_secret": "61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
        "login_url": "/login",
    }
    application = tornado.web.Application([
        (r"/", MainHandler),
        (r"/login", LoginHandler),
    ], **settings)

------------------------

xsrf
当前防范 XSRF 的一种通用的方法，是对每一个用户都记录一个无法预知的 cookie 数据，然后要求所有提交的请求中都必须带有这个 cookie 数据。如果此数据不匹配 ，那么这个请求就可能是被伪造的


要在应用配置中加上 xsrf_cookies 设定：

    settings = {
        "cookie_secret": "61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
        "login_url": "/login",
        "xsrf_cookies": True,
    }
    application = tornado.web.Application([
        (r"/", MainHandler),
        (r"/login", LoginHandler),
    ], **settings)

通过在模板中使用 专门的函数 xsrf_form_html() 来做到这一点：

    <form action="/new_message" method="post">
    {{ xsrf_form_html() }}
    <input type="text" name="message"/>
    <input type="submit" value="Post"/>
    </form>

 AJAX 的 POST 请求，使用了 jQuery 函数来为所有请求组东添加 _xsrf 值：

    function getCookie(name) {
        var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
        return r ? r[1] : undefined;
    }

    jQuery.postJSON = function(url, args, callback) {
        args._xsrf = getCookie("_xsrf");
        $.ajax({url: url, data: $.param(args), dataType: "text", type: "POST",
            success: function(response) {
            callback(eval("(" + response + ")"));
        }});
    };


-----------------------------


static_path 选项来提供静态文件服务：

    settings = {
        "static_path": os.path.join(os.path.dirname(__file__), "static"),
        "cookie_secret": "61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
        "login_url": "/login",
        "xsrf_cookies": True,
    }
    application = tornado.web.Application([
        (r"/", MainHandler),
        (r"/login", LoginHandler),
        (r"/(apple-touch-icon\.png)", tornado.web.StaticFileHandler, dict(path=settings['static_path'])),
    ], **settings)

这样配置后，所有以 /static/ 开头的请求，都会直接访问到指定的静态文件目录， 比如 http://localhost:8888/static/foo.png 会从指定的静态文件目录中访问到 foo.png 这个文件。同时 /robots.txt 和 /favicon.ico 也是会自动作为静态文件处理（即使它们不是以 /static/ 开头

为了提高性能，在浏览器主动缓存静态文件是个不错的主意。这样浏览器就不需要发送 不必要的 If-Modified-Since 和 Etag 请求，从而影响页面的渲染速度。 Tornado 可以通过内建的“静态内容分版(static content versioning)”来直接支持这种功能。

要使用这个功能，在模板中就不要直接使用静态文件的 URL 地址了，你需要在 HTML 中使用 static_url() 这个方法来提供 URL 地址：

    <html>
    <head>
        <title>FriendFeed - {{ _("Home") }}</title>
    </head>
    <body>
        <div><img src="{{ static_url("images/logo.png") }}"/></div>
    </body>
    </html>
static_url() 函数会将相对地址转成一个类似于 /static/images/logo.png?v=aae54 的 URI，v 参数是 logo.png 文件的散列值， Tornado 服务器会把它发给浏览器，并以此为依据让浏览器对相关内容做永久缓存。

由于 v 的值是基于文件的内容计算出来的，如果你更新了文件，或者重启了服务器 ，那么就会得到一个新的 v 值，这样浏览器就会请求服务器以获取新的文件内容。 如果文件的内容没有改变，浏览器就会一直使用本地缓存的文件，这样可以显著提高页 面的渲染速度。


-----------------------

本地化

不管有没有登陆，当前用户的 locale 设置可以通过两种方式访问到：请求处理器的 self.locale 对象、以及模板中的 locale 值。Locale 的名称（如 en_US）可以 通过 locale.name 这个变量访问到，你可以使用 locale.translate 来进行本地化 翻译。在模板中，有一个全局方法叫 _()，它的作用就是进行本地化的翻译。这个 翻译方法有两种使用形式：

_("Translate this string")
它会基于当前 locale 设置直接进行翻译，还有一种是：

_("A person liked this", "%(num)d people liked this", len(people)) % {"num": len(people)}
这种形式会根据第三个参数来决定是使用单数或是复数的翻译。上面的例子中，如果 len(people) 是 1 的话，就使用第一种形式的翻译，否则，就使用第二种形式 的翻译。



查看 locale 模块 的代码文档以了解 CSV 文件的格式，以及其它的本地化方法函数

----------------------

UI 模块

跟flask中的maco差不多

可以帮你创建标准的，易被重用的应用程序级的 UI 组

uimodules.py

    class Entry(tornado.web.UIModule):
        def render(self, entry, show_comments=False):
            return self.render_string(
                "module-entry.html", entry=entry, show_comments=show_comments)
app

    class HomeHandler(tornado.web.RequestHandler):
        def get(self):
            entries = self.db.query("SELECT * FROM entries ORDER BY date DESC")
            self.render("home.html", entries=entries)

    class EntryHandler(tornado.web.RequestHandler):
        def get(self, entry_id):
            entry = self.db.get("SELECT * FROM entries WHERE id = %s", entry_id)
            if not entry: raise tornado.web.HTTPError(404)
            self.render("entry.html", entry=entry)

    settings = {
        "ui_modules": uimodules,
    }
    application = tornado.web.Application([
        (r"/", HomeHandler),
        (r"/entry/([0-9]+)", EntryHandler),
    ], **settings)

在 home.html 中，你不需要写繁复的 HTML 代码，只要引用 Entry 就可以了：

    {% for entry in entries %}
        {% module Entry(entry) %}
    {% end %}

你可以为 UI 模型配置自己的 CSS 和 JavaScript ，只要复写 embedded_css、 embedded_javascript、javascipt_files、css_files 就可以了：

class Entry(tornado.web.UIModule):
    def embedded_css(self):
        return ".entry { margin-bottom: 1em; }"

    def render(self, entry, show_comments=False):
        return self.render_string(
            "module-entry.html", show_comments=show_comments)



------------------------

非阻塞式异步请求

当一个处理请求的行为被执行之后，这个请求会自动地结束。因为 Tornado 当中使用了 一种非阻塞式的 I/O 模型，所以你可以改变这种默认的处理行为——让一个请求一直保持 连接状态，而不是马上返回，直到一个主处理行为返回。要实现这种处理方式，只需要 使用 tornado.web.asynchronous 装饰器就可以了。

使用了这个装饰器之后，你必须调用 self.finish() 已完成 HTTTP 请求，否则 用户的浏览器会一直处于等待服务器响应的状态：

class MainHandler(tornado.web.RequestHandler):
    @tornado.web.asynchronous
    def get(self):
        self.write("Hello, world")
        self.finish()

下面是一个使用 Tornado 内置的异步请求 HTTP 客户端去调用 FriendFeed 的 API 的例 子：

class MainHandler(tornado.web.RequestHandler):
    @tornado.web.asynchronous
    def get(self):
        http = tornado.httpclient.AsyncHTTPClient()
        http.fetch("http://friendfeed-api.com/v2/feed/bret",
                   callback=self.on_response)

    def on_response(self, response):
        if response.error: raise tornado.web.HTTPError(500)
        json = tornado.escape.json_decode(response.body)
        self.write("Fetched " + str(len(json["entries"])) + " entries "
                   "from the FriendFeed API")
        self.finish()

可以参阅 demo 中的 chat 这个例子

-----------------------

异步 HTTP 客户端

Tornado 包含了两种非阻塞式 HTTP 客户端实现：SimpleAsyncHTTPClient 和 CurlAsyncHTTPClient。前者是直接基于 IOLoop 实现的，因此无需外部依赖关系。 后者作为 Curl 客户端，需要安装 libcurl 和 pycurl 后才能正常工作，但是对于使用 到 HTTP 规范中一些不常用内容的站点来说，它的兼容性会更好。为防止碰到 旧版本中异步界面的 bug，我们建议你安装最近的版本的 libcurl 和 pycurl。


这些客户端都有它们自己的模组(tornado.simple_httpclient 和 tornado.curl_httpclient)，你可以通过 tornado.httpclient 来指定使用哪一种 客户端，默认情况下使用的是 SimpleAsyncHTTPClient，如果要修改默认值，只要 在一开始调用 AsyncHTTPClient.configure 方法即可：

AsyncHTTPClient.configure('tornado.curl_httpclient.CurlAsyncHTTPClient')

----------------------

Tornado 的 auth 模块实现了现在很多流行站点的用户认证方式，包括 Google/Gmail、Facebook、Twitter、Yahoo 以及 FriendFeed。这个模块可以让用户使用 这些站点的账户来登陆你自己的应用，然后你就可以在授权的条件下访问原站点的一些服 务，比如下载用户的地址薄，在 Twitter 上发推等。

下面的例子使用了 Google 的账户认证，Google 账户的身份被保存到 cookie 当中，以便 以后的访问使用：

class GoogleHandler(tornado.web.RequestHandler, tornado.auth.GoogleMixin):
    @tornado.web.asynchronous
    def get(self):
        if self.get_argument("openid.mode", None):
            self.get_authenticated_user(self._on_auth)
            return
        self.authenticate_redirect()

    def _on_auth(self, user):
        if not user:
            self.authenticate_redirect()
            return
        # Save the user with, e.g., set_secure_cookie()


调试模式和自动重载
如果你将 debug=True 传递给 Application 构造器，该 app 将以调试模式 运行。在调试模式下，模板将不会被缓存，而这个 app 会监视代码文件的修改， 如果发现修改动作，这个 app 就会被重新加载。在开发过程中，这会大大减少 手动重启服务的次数。然而有些问题（例如 import 时的语法错误）还是会让服务器 下线，目前的 debug 模式还无法避免这些情况。

调试模式和 HTTPServer 的多进程模式不兼容。在调试模式下，你必须将 HTTPServer.start 的参数设为不大于 1 的数字。

调试模式下的自动重载功能可以通过独立的模块 tornado.autoreload 调用， 作为测试运行器的一个可选项目，tornado.testing.main 中也有用到它。

---------------------

在 FriendFeed 中，我们使用 nginx 做负载均衡和静态文件伺服。 我们在多台服务器上，同时部署了多个 Tornado 实例，通常，一个 CPU 内核 会对应一个 Tornado 线程。

因为我们的 Web 服务器是跑在负载均衡服务器（如 nginx）后面的，所以需要把 xheaders=True 传到 HTTPServer 的构造器当中去。这是为了让 Tornado 使用 X-Real-IP 这样的的 header 信息来获取用户的真实 IP地址，如果使用传统 的方法，你只能得到这台负载均衡服务器的 IP 地址。

下面是 nginx 配置文件的一个示例，整体上与我们在 FriendFeed 中使用的差不多。 它假设 nginx 和 Tornado 是跑在同一台机器上的，四个 Tornado 服务跑在 8000-8003 端口上：

user nginx;
worker_processes 1;

error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
    use epoll;
}

http {
    # Enumerate all the Tornado servers here
    upstream frontends {
        server 127.0.0.1:8000;
        server 127.0.0.1:8001;
        server 127.0.0.1:8002;
        server 127.0.0.1:8003;
    }

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;

    keepalive_timeout 65;
    proxy_read_timeout 200;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    gzip on;
    gzip_min_length 1000;
    gzip_proxied any;
    gzip_types text/plain text/html text/css text/xml
               application/x-javascript application/xml
               application/atom+xml text/javascript;

    # Only retry if there was a communication error, not a timeout
    # on the Tornado server (to avoid propagating "queries of death"
    # to all frontends)
    proxy_next_upstream error;

    server {
        listen 80;

        # Allow file uploads
        client_max_body_size 50M;

        location ^~ /static/ {
            root /var/www;
            if ($query_string) {
                expires max;
            }
        }
        location = /favicon.ico {
            rewrite (.*) /static/favicon.ico;
        }
        location = /robots.txt {
            rewrite (.*) /static/robots.txt;
        }

        location / {
            proxy_pass_header Server;
            proxy_set_header Host $http_host;
            proxy_redirect false;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;
            proxy_pass http://frontends;
        }
    }
}

Tornado 对 WSGI 只提供了有限的支持，即使如此，因为 WSGI 并不支持非阻塞式的请求，所以如果你使用 WSGI 代替 Tornado 自己的 HTTP 服务的话，那么你将无法使用 Tornado 的异步非阻塞式的请求处理方式




