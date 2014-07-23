

import



    import "fmt"

    or 

    import(
        "fmt"
    )

两种写法

1. 相对路径

    import "./models" //当前同一个文件目录下的model. 不建议使用

2. 绝对路径

    import "shorturl/model" // gopath/src/shorturl/mdoel

点操作

    import(
        . "fmt"
    )

    类似python
    from fmt import *

别名操作

    import(
        f "fmt"
    )

    类似python的
    import fmt as f

_操作

    import (
        _ "github.com/ziutek/mymysql/godrv"
    )

    不直接使用包里的函数, 只调用该包的init
