package main

/*
常量, 在程序编译阶段就确定下来的值, 在运行时无法改变
数值, 布尔值, 字符串等

=右边, 必须为常量或常量表达式(使用的函数必须为内置函数-编译期行为)

*/

import "fmt"

func main() {

	//定义 const constantName [type] = value
	const a = 1
	fmt.Println(a)

	const Pi float32 = 3.1415926
	fmt.Println(Pi)

	const prefix = "test_"
	fmt.Println(prefix)

}
