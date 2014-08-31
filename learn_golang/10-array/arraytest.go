package main

import (
	"fmt"
)

/*
array,数组
注意, 数组的长度也是类型的一部分(该数组类型的一个内置常量), 所以[3]int, [4]int是不同的类型, 数组不能改变

数组的传递是值传递, 传递的是副本,而不是指针, slice是指针
值类型, 所有值类型在进行赋值操作和作为参数传递时,都将产生一次复制操作

*/

func main() {
	// 定义 var arr [n]type,  n>=0
	// 元素的类型和长度都是数组类型的一部分。数组默认是零值的，对于 int 数组来说就是 0。
	var arr [10]int
	arr[0] = 42
	arr[1] = 13

	fmt.Println("len:", len(arr))

	for i, v := range arr {
		fmt.Println(i, v)
	}

	// := 声明
	// 使用这个语法来在一行内初始化一个数组
	a := [3]int{1, 2, 3}
	b := [10]int{1, 2, 3}

	c := [...]int{4, 5, 6}
	fmt.Println(a)
	fmt.Println(b)
	fmt.Println(c)

	// 二维数组
	doubleArr := [2][4]int{[4]int{1, 2, 3, 4}, [4]int{5, 6, 7, 8}}
	easyArr := [2][4]int{{1, 2, 3, 4}, {5, 6, 7, 8}}
	// 注意在使用 fmt.Println 来打印的时候，数组使用[v1 v2 v3 ...] 的格式显示
	fmt.Println(doubleArr)
	fmt.Println(easyArr)

}
