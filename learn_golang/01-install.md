



mac

    brew install go
    or
    下载pkg包

安装后


    export GOROOT=/usr/local/go
    export PATH=$PATH:$GOROOT/bin

验证是否已安装

    go

GOPATH

    允许有多个目录,
    export GOPATH=/Users/ken/goworkspace/libs:/Users/ken/goworkspace/Counter

    默认将go get内容放在第一个目录下

    libs 放置公有包
      |- src
      |- pkg
      |- bin

    Counter 具体项目
      |- src  存放源码
      |- pkg  编译后生成的文件
      |- bin  编译后生成的可执行文件


获取远程包

    go get github.com/astaxie/beedb

    本质上 : clone到src -> go install

    然后在其他项目里可以 import "github.com/astaxie/beedb"


程序结构

    1.通过 package组织
    2.只有package名称为main的包可以包含main函数
    3.一个程序有且仅有一个main包
    4.通过import关键字导入其他非main包

go命令工具

    go build 测试编译, 有一些规则

        go build hello.go
        ./hello

    go clean 移除当前源码包里编译生成的文件

    go fmt格式化写好的代码

        go fmt xx.go

    go get 动态获取远程包

    go install 生成结果文件(可执行文件或者.a包) -> 把编译好的结果移到$GOPATH/pkg或者$GOPATH/bin中

    go test 运行测试用的可执行文件  *_test.go


    go version 查看版本
    go env 查看当前go环境变量
    go list 列出当前安装的所有package

    go run 编译并运行go语言程序


开发工具

    LiteIDE
    Sublime Text
    * Vim
        + gocode goimports gotags
    Emacs


go的保留字? 文档吧

