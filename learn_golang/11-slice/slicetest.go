package main

/*
slice, 数组切片, 列表, 可变数组 "动态数组"

就像一个指向数组的指针, 但是更复杂

引用类型

slice总是指向一个底层array, 声明同array,但不需要长度

从概念上来看,slice像一个结构体,包含三个元素
1. 一个指针, 指向数组中slice指定的开始位置
2. 长度, 即slice的长度, len
3. 最大长度, slice开始为指导数组的最后位置的长度, cap

*/

import (
	"fmt"
)

func main() {
	// 1. 声明 var aslice []type
	var fslice []int

	fmt.Println("fslice", fslice)

	// 声明并init
	aslice := []byte{'a', 'b', 'c'}
	fmt.Println("aslice", aslice)

	// make创建
	myslice1 := make([]int, 5)
	myslice2 := make([]int, 5, 10)

	fmt.Println("myslice1", myslice1, len(myslice1), cap(myslice1))
	fmt.Println("myslice2", myslice2, len(myslice2), cap(myslice2))

	// 2. 通过一个array声明, 指向实际的array

	var ar = [10]byte{'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'}
	fmt.Println("ar", ar)

	var a, b []byte //声明

	// 同python的切片操作
	a = ar[2:5] // ar[2], ar[3], ar[4]
	b = ar[3:5] // ar[3]  ar[4]

	fmt.Println("a", a)
	fmt.Println("b", b)

	// 3. 从slice中获取slice, 要绘制指向array的图, 才能知道, len, cap的真正大小
	// len() 获取长度, cap获取最大容量

	var aSlice, bSlice []byte
	aSlice = ar[3:7] // d e f g,   len=4, cap=7   (10-3),后面总共能放7个

	fmt.Println("aSlice", aSlice, len(aSlice), cap(aSlice))

	bSlice = aSlice[1:3] // e f, len=2, cap=6

	fmt.Println("bSlice", bSlice, len(bSlice), cap(bSlice)) //

	// 4. slice是引用类型, 所以改变其中的值时, 其他所有引用都会改变, 包括原生array
	fmt.Println("do change")
	bSlice[0] = '0'
	fmt.Println("aSlice", aSlice, len(aSlice), cap(aSlice))
	fmt.Println("bSlice", bSlice, len(bSlice), cap(bSlice)) //
	fmt.Println("ar", ar)

	// 5. append方法, 向slice里面追加一个或多个元素, 然后返回一个和slcie一样类型的slice
	// 5.1 cap-len>0 时, append会改变slice所引用数组的内容, 从而影响到同一个数组的其他slice [特别注意]  所有都变!!!! 坑
	fmt.Println("do append 1")
	cSlice := append(bSlice, '1', '2')
	fmt.Println("aSlice", aSlice, len(aSlice), cap(aSlice))
	fmt.Println("bSlice", bSlice, len(bSlice), cap(bSlice)) //
	fmt.Println("cSlice", cSlice, len(cSlice), cap(cSlice)) //
	fmt.Println("ar", ar)

	// 5.2 cap-len==0, 此时动态分配新的空间, 将指针指向这个空间, 原数组和引用原数组的其他slice不变
	fmt.Println("do append 2")
	dSlice := append(bSlice, '1', '2', '3', '4', '5') //刚好超出一个, totally new, 否则, 还是在原数组上操作
	fmt.Println("aSlice", aSlice, len(aSlice), cap(aSlice))
	fmt.Println("bSlice", bSlice, len(bSlice), cap(bSlice)) //
	fmt.Println("cSlice", cSlice, len(cSlice), cap(cSlice)) //
	fmt.Println("dSlice", dSlice, len(dSlice), cap(dSlice)) //
	fmt.Println("ar", ar)

	// 6. copy 方法, 从源slice中肤质元素到目标dst, 且返回复制元素的个数
	// copy(dest, source) 会按短的那个数组来复制
	fmt.Println("do copy")
	//var dest_slice []byte 只声明不初始化是没办法复制成功的, 注意, 编译不报错
	dest_slice := make([]byte, 2)
	copy_count := copy(dest_slice, bSlice)
	fmt.Println("source, dest, copy_count", bSlice, dest_slice, copy_count)

}
