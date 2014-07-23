package main

import (
	"fmt"
)

const (
	x = iota //默认开始值0, 没调用一次+1
	y = iota
	z = iota
	w // 默认和前一个值的字面相同, w = iota
)

const v = iota //遇到const, iota重置

func main() {

	fmt.Println(x, y, z, w, v)

}
