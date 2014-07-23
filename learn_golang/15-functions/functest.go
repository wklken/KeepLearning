package main

/*

func 声明, 小写字母开头本包可见, 大写字母开头才能被其他包使用

func funcName(input1 type1, input2, type2) (output1 type1, output2 type2) {
    //可以返回多个值

    return value1, value2
}

func关键字声明
可以有一个或多个参数, 每个参数后面带类型, 逗号分隔
func funcName(input1 type1, input2 type2) output1 type1
同类型参数
func funcName(input1, input2 type) output1 type1

返回值, 可以name type声明, 也可以只有type声明

一个返回值
func funcName(input1 type1, input2 type2) output1 type1
func funcName(input1 type1, input2 type2) type1

没有返回值

func funcName(input1 type1, input2, type2) {

------------------
传指针的好处:
1. 多个函数能够操作同一个对象
2. 比较轻量级 8byte, 只是攒内存地址, 值传递每次都要copy副本

3. string/slice/map, 实现机制类似指针, 可以直接传递, 而不用取地址后传指针. 注意, 若函数改变了slice的长度,仍需要取slice地址传指针


*/
import (
	"fmt"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

//多个返回值
func SumAndProduct(A, B int) (int, int) {
	return A + B, A * B
}

// 命名返回值
func SumAndProduct2(A, B int) (Add int, Multiplied int) {

	Add = A + B
	Multiplied = A * B
	return
}

// 变参
func myFunc(arg ...int) {
	for _, n := range arg {
		fmt.Println("arg", n)
	}
}

// 任意类型变参
func myFunc2(arg ...interface{}) {
	for _, n := range arg {
		fmt.Println("arg", n)
	}
}

// 传值
func add1(a int) int {
	a = a + 1
	return a
}

// 传指针
func add2(a *int) {
	*a = *a + 1
}

// 函数也是一种变量, 可以通过type定义, 他的类型就是: 所有拥有相同的参数和返回值
// type typeName func(input1 inputtype1, input2 inputtype2 [, ..]) (result resultType [,...])

type testInt func(int) bool //声明一个函数类型
func isOdd(i int) bool {
	if i%2 == 0 {
		return false
	}
	return true
}
func isEven(i int) bool {
	if i%2 == 0 {
		return true
	}
	return false
}
func filter(slice []int, f testInt) []int {
	var result []int

	for _, value := range slice {
		if f(value) {
			result = append(result, value)
		}
	}
	return result
}

func main() {

	x := 3
	y := 4
	fmt.Println(max(x, y))

	r1, r2 := SumAndProduct(x, y)
	fmt.Println(r1, r2)

	r3, r4 := SumAndProduct2(x, y)
	fmt.Println(r3, r4)

	myFunc(1, 2, 3)
	a := []int{4, 5}
	myFunc(a...)

	myFunc2(1, "test")

	x = 3
	fmt.Println("origin", x)
	x1 := add1(x)
	fmt.Println("x", x)
	fmt.Println("x1", x1)

	add2(&x)
	fmt.Println("after & * add operation", x)

	//------------------

	slice := []int{1, 2, 3, 4, 5, 6, 7}
	fmt.Println("slice=", slice)

	odd := filter(slice, isOdd)
	fmt.Println("odd", odd)

	even := filter(slice, isEven)
	fmt.Println("even", even)

}
