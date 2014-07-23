package main

import (
	"fmt"
	"math"
)

/*
把函数当做struct的字段一样来处理...

函数的另一种形态: 带接收者的函数, method(可以理解为, 某个类型的函数)

A method is a function with an implicit first argument called a receiver

func (r ReceiverType) funcName(parameters) (results)

method是属于receiver的

一般情况下, receiver以值传递, 而非引用传递. 部队原实例对象发生操作
可以是指针, 指针作为receiver会对实例对象的内容发生操作

*/

type Rectangle struct {
	width, height float64
}

type Circle struct {
	radius float64
}

// just functions
func area_of_rectangle(r Rectangle) float64 {
	return r.width * r.height
}

func area_of_circle(c Circle) float64 {
	return c.radius * c.radius * math.Pi
}

// methods 虽然method名字一样,但是receiver不同,则method不同.   method里面可以访问接收者的字段.
func (r Rectangle) area() float64 {
	return r.width * r.height
}

func (c Circle) area() float64 {
	return c.radius * c.radius * math.Pi
}

// 2.指针
type Color byte
type Box struct {
	color Color
}

// 如果不传指针, 那么SetColor接受的其实是Box的一个copy
// 如果一个method的receiver是*T, 你可以在一个T类型的实例变量V上面调用这个method, 而不需要&V去调用这个method
func (b *Box) SetColor(c Color) {
	b.color = c
}

// 3. method继承

type Human struct {
	name string
	age  int
}

type Student struct {
	Human
	score int
}

func (h *Human) SayHi() {
	fmt.Println("hi, I am", h.name)
}

// 4. method重写
type Employee struct {
	Human
	company string
}

func (e Employee) SayHi() {
	fmt.Println("hi, My name is", e.name, "and I am an employee")
}

// a receiver
func main() {

	r := Rectangle{12, 2}
	c := Circle{10}

	fmt.Println(area_of_rectangle(r), r.area())
	fmt.Println(area_of_circle(c), c.area())

	const RED = 1
	const BLACK = 2

	b := Box{RED}
	fmt.Println("b.color", b.color)
	b.SetColor(BLACK)
	fmt.Println("b.color", b.color)

	//---------------
	mark := Student{Human{"Mark", 25}, 100}
	mark.SayHi()

	tom := Employee{Human{"Tom", 27}, "Google"}
	tom.SayHi()

}
