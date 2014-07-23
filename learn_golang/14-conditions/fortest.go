package main

/*

for 是 go的 while

仅支持for


语法
for e1; e2; e3 {
}

e1 初始化, 不支持逗号表达式, 只能以平行赋值
e2 每次循环检查
e3 每次循环结束后调用


---------------------

break 跳出当前循环
continue 跳出本次循环

嵌套过深,break可以配合标签使用, 跳转到标签所指定的位置


goto/break/continue

均可配合标签使用
标签区分大小写, 声明但不用会导致编译错误
break/continue可配合标签使用, 用于多重循环跳出
goto是调整执行位置, 与其他两个结果不相同


*/

import (
	"fmt"
)

func main() {

	// 1. 基本
	sum := 0
	for index := 0; index < 10; index++ {
		sum += index
	}
	fmt.Println("sum", sum)

	// 2. 精简, for -> while
	sum1 := 1
	for sum1 < 1000 {
		sum1 += sum1
	}
	fmt.Println("sum1", sum1)

}
