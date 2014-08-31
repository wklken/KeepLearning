package main

import (
	"fmt"
)

/*

interface让面向对象/内容组织的实现变得非常方便

interface是一组method的集合. 我们通过interface来定义对象的一组行为
(接口 是方法特征的命名集合。)

在golang中, 一个类只要实现了接口要求的所有函数, 我们就说这个类实现了这个接口


----------------
非侵入式接口
1.Go 语言标准库, 再也不需要绘制额类库的继承树图了
2.实现时, 只需要关心自己应该提供哪些方法
  不用再纠结接口需要拆得多细才合理, 接口由使用方按需定义
3.不用再为了实现一个借口而导入一个包

---------------

// interface可以被任意对象实现
// 任意的类型都实现了 空interface  interface{}   包含0个method
// 可以用来存储任意类型, 参数传递任意类型 或者 函数定义返回值是任意类型

*/

type Human struct {
	name  string
	age   int
	phone string
}

func (h Human) SayHi() {
	fmt.Printf("Hi, I am %s and you can call me on %s\n", h.name, h.phone)
}

func (h Human) Sing(lyrics string) {
	fmt.Printf("La la, la la la...%s\n", lyrics)
}

// 接口定义
type Men interface {
	SayHi()
	Sing(lyrics string)
}

// interface同struct, 可以嵌入继承
type Student interface {
	Men
	Study()
}

func main() {

	mike := Human{"Mike", 25, "222-222-222"}
	mike.SayHi()
	mike.Sing("November rain")

	var i Men
	// 为什么上面是h *Human, interface就会编译报错?
	i = mike
	i.SayHi()

	// 接口继承 - 怎么处理的?

	// interface类型检查 Comma-ok断言
	var a interface{} = "abc"
	_, ok := a.(int)
	if ok {
		fmt.Println("It's int")
	}

	if _, ok := a.(string); ok {
		fmt.Println("It's string")
	}

}
