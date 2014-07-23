package main //声明文件的package

//用于输出的包, 不能包含没有用到的包, 否则会报错

import "fmt"

//入口函数, 无参数, 无返回值
func main() {

	/*
		   多行注释
	       天生支持utf-8
	*/
	fmt.Println("hello world, 你好")

}
