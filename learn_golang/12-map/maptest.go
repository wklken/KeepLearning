package main

/*
map 字典
格式 map[keyType]valueType

map key: int/string以及完全定义了 == != 的类型

map是无序的
map长度是不固定的
len可以获取map的key数量


*/

import (
	"fmt"
)

func main() {

	// 1.声明
	var numbers map[string]int

	// 使用make初始化
	numbers = make(map[string]int)
	numbers["one"] = 1
	numbers["two"] = 2

	fmt.Println("numbers", numbers)
	fmt.Println(numbers["two"])

	// modify
	numbers["two"] = 22
	fmt.Println("numbers", numbers)
	fmt.Println(numbers["two"])

	// delete
	delete(numbers, "two")
	fmt.Println("numbers", numbers)

	// judge if exists
	_, ok := numbers["two"]
	if ok {
		fmt.Println("key two exists")
	} else {
		fmt.Println("key two not exists")
	}

	// 2. 另一种直接声明
	rating := map[string]float32{"C": 5, "GO": 5.5}

	// 3. 遍历

}
