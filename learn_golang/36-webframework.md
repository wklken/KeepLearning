


web项目目录结构

    main.go
    
    models
    views
    controllers

    conf
    utils
    statics

常见的web框架

--------------
martini best?  类似flask
https://github.com/go-martini/martini

优点：

小巧，代码设计非常优秀

使用injection的方式将参数注入到handler函数中，解决了revel框架的问题

session，orm等都可以通过中间件的形式注入到框架中

缺点：

由于martini相对于其他框架还很年轻，目前一些功能还不支持。

---------------

revel 类java的play
一个很完备的框架，设计精巧  暂无ORM??
优点：


一个很完备的框架，设计精巧

支持热修改，不需要重启服务

自带cache，session

暂无orm集成

缺点：

我觉得revel的最大缺点是修改了太多的库函数，以至于标准的http库的handler都无法兼容，这个问题martini使用了一种极其优雅的方式解决了。
https://github.com/revel/revel


---------------
goji
https://github.com/zenazn/goji

---------------
beego 类tornado

优点：

国人开发，因此，有中文文档

很完备，支持热修改，不需要重启服务

自带ORM，beedb

缺点：

灵活性不够

http://beego.me/
https://github.com/astaxie/beego/

---------------
web.go 轻量?
https://github.com/hoisie/web

类似于web.py，最近好像不怎么更新了。


