package main

import (
	"fmt"
)

/*
结构体, 一组字段的集合, 其他属性或字段的容器

*/

type person struct {
	name string
	age  int
}

func Older(p1, p2 person) (person, int) {
	if p1.age > p2.age {
		return p1, p1.age - p2.age
	}
	return p2, p2.age - p1.age
}

// 匿名字段(嵌入字段), 只提供类型, 不写字段名
// 自定义类型和内置类型, 都可以作为匿名字段

type Human struct {
	name   string
	age    int
	weight int
	score  int
}

//type Skills []string

type Student struct {
	Human      //匿名字段, 默认Student包含了Human的所有字段. 实现了字段的继承
	speciality string
	score      int
}

func main() {

	var p person
	p.name = "tom"
	p.age = 25
	fmt.Println("The person's name is", p.name)

	// 顺序初始化
	p1 := person{"ken", 27}
	fmt.Println("p1 name", p1.name)

	// k-v初始化
	p2 := person{age: 23, name: "Luna"}
	fmt.Println("p2 name", p2.name)

	sp := &p2
	fmt.Println("sp name", sp.name) //可以直接取值, 不需要*sp

	rp, ra := Older(p1, p2)
	fmt.Println("the older one", rp, "age diff:", ra)

	// ----------------

	mark := Student{Human{"Mark", 25, 120, 1}, "CS", 100}

	fmt.Println("mark", mark.name, mark.age, mark.weight, mark.speciality)
	fmt.Println("mark", mark.Human.name, mark.Human.age, mark.Human.weight, mark.speciality)

	//  想访问重载后对应匿名类型的字段, 可以通过匿名字段名来访问
	fmt.Println("Same field name", mark.score, mark.Human.score) // 100 1
}
