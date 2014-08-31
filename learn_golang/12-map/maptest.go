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
	// 要创建一个空 map，需要使用内建的 make:make(map[key-type]val-type).
	numbers = make(map[string]int)
	// 使用典型的 make[key] = val 语法来设置键值队。
	numbers["one"] = 1
	numbers["two"] = 2

	fmt.Println("numbers", numbers)
	// 使用 name[key] 来获取一个键的值
	fmt.Println(numbers["two"])
	fmt.Println("len", len(numbers))

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
	// 注意一个 map 在使用 fmt.Println 打印的时候，是以 map[k:v k:v]的格式输出的。
	fmt.Println(rating)

	// 3. 遍历
	kvs := map[string]string{"a": "apple", "b": "banana"}
	for k, v := range kvs {
		fmt.Printf("%s -> %s\n", k, v)
	}

}
