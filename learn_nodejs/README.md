learn nodejs
=================


### 参考

- [nodejs beginner](http://nodeguide.com/beginner.html)
- [node入门](http://www.nodebeginner.org/index-zh-cn.html)
- [七天学会nodejs](http://nqdeng.github.io/7-days-nodejs)
- [nodejs包教不包会](https://github.com/alsotang/node-lessons) 有实战内容
- [从0开始nodejs](http://blog.fens.me/series-nodejs/)
- [nodejs初学者入门资料](http://blog.jobbole.com/17174/)


### 资源入口

node官网 https://nodejs.org/en/
express官网 http://expressjs.com/  中文 http://expressjs.com/zh/
expressjs cn http://www.expressjs.com.cn/

v4.1.1 doc https://nodejs.org/api/
v0.12.7 doc https://nodejs.org/docs/latest-v0.12.x/api/


all version doc index https://nodejs.org/docs/

doc index:

- buffer      http://nodejs.org/api/buffer.html
- stream      http://nodejs.org/api/stream.html
- fs          http://nodejs.org/api/fs.html
- path        http://nodejs.org/api/path.html
- http        http://nodejs.org/api/http.html
- https       http://nodejs.org/api/https.html
- url         http://nodejs.org/api/url.html
- querystring http://nodejs.org/api/querystring.html
- zlib http://nodejs.org/api/zlib.html
- net http://nodejs.org/api/net.html
- process http://nodejs.org/api/process.html
- child_process http://nodejs.org/api/child_process.html
- cluster http://nodejs.org/api/cluster.html
- domain http://nodejs.org/api/domain.html


### Install

1. node
2. nvm(控制不同node版本) : https://github.com/creationix/nvm



### concept

[Node.js究竟是什么](http://www.ibm.com/developerworks/cn/opensource/os-nodejs/index.html?ca=drs#ibm-pcon)


### CLI


npm install argv
    node_modules/argv
npm install argv -g
    in /usr/local/


npm

```
NPM提供了很多命令，例如install和publish，使用npm help可查看所有命令。

使用npm help <command>可查看某条命令的详细帮助，例如npm help install。

在package.json所在目录下使用npm install . -g可先在本地安装当前命令行程序，可用于发布前的本地测试。

使用npm update <package>可以把当前目录下node_modules子目录里边的对应模块更新至最新版本。

使用npm update <package> -g可以把全局安装的对应命令行程序更新至最新版。

使用npm cache clear可以清空NPM本地缓存，用于对付使用相同版本号发布新版本代码的人。

使用npm unpublish <package>@<version>可以撤销发布自己发布过的某个版本代码。
```

cnpm: http://npm.taobao.org/


---------


要熟悉官方API文档。并不是说要熟悉到能记住每个API的名称和用法，而是要熟悉NodeJS提供了哪些功能，一旦需要时知道查询API文档的哪块地方。

要先设计再实现。在开发一个程序前首先要有一个全局的设计，不一定要很周全，但要足够能写出一些代码。

要实现后再设计。在写了一些代码，有了一些具体的东西后，一定会发现一些之前忽略掉的细节。这时再反过来改进之前的设计，为第二轮迭代做准备。

要充分利用三方包。NodeJS有一个庞大的生态圈，在写代码之前先看看有没有现成的三方包能节省不少时间。

不要迷信三方包。任何事情做过头了就不好了，三方包也是一样。三方包是一个黑盒，每多使用一个三方包，就为程序增加了一份潜在风险。并且三方包很难恰好只提供程序需要的功能，每多使用一个三方包，就让程序更加臃肿一些。因此在决定使用某个三方包之前，最好三思而后行。
