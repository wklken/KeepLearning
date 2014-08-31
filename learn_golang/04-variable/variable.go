package main

import "fmt"

/*
变量相关的代码
*/

func main() {

	//定义一个变量 var variableName type
	var a int
	fmt.Println("a", "=", a) //未初始化, 默认值0
	//定义并初始化 var variableName type = value
	var a1 int = 1
	fmt.Println("a", "=", a1)

	//定义多个变量 var vname1, vname2, vname3 type
	var b, c, d int
	fmt.Println("b, c, d", "=", b, c, d)
	//定义并初始化 var vname1, vname2, vname3 type = v1, v2, v3
	var b1, c1, d1 int = 2, 3, 4
	fmt.Println("b1, c1, d1", "=", b1, c1, d1)

	//简化 不显式声明类型, 自动判断, 反向推断 var vname1, vname2, vname3 = v1, v2, v3
	var b2, c2, d2 = 4, 5, 6
	fmt.Println("b2, c2, d2", "=", b2, c2, d2)

	// 再简化, 简短声明:=   出现在:=左侧的变量不应该是已被声明过的, 否则会导致编译错误
	// 限制, 只能用在函数内部, 在函数外部无法编译通过, 外部变量一定有var
	a2 := 1
	b3, c3, d3 := 7, 8, 9
	fmt.Println("a2, b3, c3, d3", "=", a2, b3, c3, d3)

	// 丢弃
	_, b4 := 10, 11
	fmt.Println("b4", "=", b4)

	//注意: 对于已声明但是没有使用的变量, 编译阶段会报错

}
