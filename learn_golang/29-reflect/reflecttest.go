package main

import (
	"fmt"
	"reflect"
)

/*
程序动态运行时的状态

转成reflect对象

reflect.TypeOf(i)  类型元数据, 可以获取类型定义里面的所有元素

reflect.ValueOf(i)  实际的值, 可以获取或改变

*/

func main() {

	var x float64 = 3.4
	v := reflect.ValueOf(x)
	fmt.Println("type:", v.Type())
	fmt.Println("kind is float64", v.Kind() == reflect.Float64)
	fmt.Println("value", v.Float())

	// 报错, 原值不可修改
	//v.SetFloat(7.1)

	// 正确的修改方式
	p := reflect.ValueOf(&x)
	v1 := p.Elem()
	v1.SetFloat(7.1)
	fmt.Println("value", v1.Float())

}
