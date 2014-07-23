package main

/*

sgo中的switch默认相当于每个case最后带有break, 匹配成功后不会向下执行其他case,而是跳出整个switch
可以调用fallthrough强制执行后面的case代码
*/

import (
	"fmt"
)

func main() {

	// 几种形式
	a := 1
	switch a {
	case 0:
		fmt.Println("0")
	case 1:
		fmt.Println("1")
	case 2, 3, 4:
		fmt.Println("2, 3, 4")
	default:
		fmt.Println("default")
	}

	// another
	//switch a := 1; {
	switch {
	case a > 0:
		fmt.Println("a > 0")
	case a == 0:
		fmt.Println("a == 0")
	case a < 0:
		fmt.Println("a < 0")
	}

	// fallthrough
	i := 6
	switch i {
	case 5:
		fmt.Println("check 5")
	case 6:
		fmt.Println("check 6")
		fallthrough
	case 7:
		fmt.Println("check 7")
		fallthrough
	default:
		fmt.Println("default")

	}

}
