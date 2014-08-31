package main

/*
常量, 在程序编译阶段就确定下来的值, 在运行时无法改变
数值, 布尔值, 字符串等

=右边, 必须为常量或常量表达式(使用的函数必须为内置函数-编译期行为)


Go 支持字符、字符串、布尔和数值常量

*/

import "fmt"

//const 语句可以出现在任何 var 语句可以出现的地方
const s string = "constant"

func main() {

	fmt.Println(s)

	// 定义 const constantName [type] = value
	// type可选
	const a = 1
	fmt.Println(a)

	const Pi float32 = 3.1415926
	fmt.Println(Pi)

	const prefix = "test_"
	fmt.Println(prefix)

	//数值型常量是没有确定类型的，直到它们被给定一个类型，比如说一次显示的类型转化。
	const n = 500000000
	const d = 3e20 / n
	fmt.Println(d)
	fmt.Println(int64(d))

}
