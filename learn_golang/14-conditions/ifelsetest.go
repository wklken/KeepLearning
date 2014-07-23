package main

/*
1. 条件语句不需要括号
2. 无论语句体里有几条语句, 花括号必须有
3. 做花括号必须与if/else同一行

*/

import (
	"fmt"
)

func main() {

	// 1. simple
	x := 10
	if x > 10 {
		fmt.Println("x > 10")
	} else {
		fmt.Println("x <= 10")
	}

	// if允许在条件判断语句里面声明变量, 作用域只在该条件逻辑块内
	// 初始化可以使用多重赋值   x, y, z := v1, v2, v3
	if x := 100 - 10; x > 10 {
		fmt.Println("x > 10")
	} else {
		fmt.Println("x <= 10")
	}

	// if else if else
	if x == 3 {
		fmt.Println("x = 3")
	} else if x < 3 {
		fmt.Println("x < 3")
	} else {
		fmt.Println("x > 3")
	}

}
