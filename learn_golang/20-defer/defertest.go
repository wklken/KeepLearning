package main

import (
	"fmt"
)

/*

defer, 延迟语句, 可以在函数中添加多个defer, 函数值想到最后时, defer语句会按照逆序执行, 最后该函数返回

可以用于资源回收操作

相当于: 预设一个函数调用, 在函数返回时刻云模型

*/

func ReadWrite() bool {
	//file.Open("file")
	//defer file.Close()

	//....
	fmt.Println("test")

	return true
}

func main() {

	for i := 0; i < 5; i++ {
		defer fmt.Println(i)
	}

	// defer + 匿名函数
	defer func() {
		fmt.Println("do something")
	}()

}
