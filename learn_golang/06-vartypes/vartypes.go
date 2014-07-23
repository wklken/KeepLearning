package main

/*
变量类型

类型转换
1. go中没有隐式类型转换, 均必须显式
2. 转换之发生在两种互相兼容的类型之间


*/

import "fmt"

import "errors"

func main() {

	// boolean, default false, 不能用数字代表true/false
	var isActive bool
	var enabled, disabled = true, false
	valid := false
	fmt.Println(isActive, enabled, disabled, valid)

	// 数值类型, 注意这些类型之间不允许互相赋值或操作, 否则编译期报错

	var a int8
	var b int16

	// rune是int32别称
	var c1 rune
	var c2 int32

	var d int64

	// byte是uint8别称
	var e1 byte
	var e2 uint8

	var f uint16
	var g uint32
	var h uint64

	fmt.Println(a, b, c1, c2, d, e1, e2, f, g, h)

	// float, default float64
	var i float32
	var j float64

	// complex, default complex128
	var k complex64 = 5 + 5i

	fmt.Println(i, j, k)

	//string, 都采用utf-8字符集编码  双引号或者``, 不可变类型
	var astr string
	var emptystr string = ""

	no, yes, maybe := "no", "yes", "maybe"

	fmt.Println(astr, emptystr, no, yes, maybe)

	// string -> bytes -> string
	s := "hello"
	c := []byte(s)
	c[0] = 'c'
	s2 := string(c)
	fmt.Println(s2)

	// 连接 +
	fmt.Println(s + "world")

	//错误类型, 内置error类型, 专门用来处理错误信息
	err := errors.New("test err")
	fmt.Println(err)

}
