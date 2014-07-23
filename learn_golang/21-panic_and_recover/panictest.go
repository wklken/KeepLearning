package main

import (
	"fmt"
)

/*
panic, 内建函数: 中断原有流程, 进入一个panic的流程中.

当函数F中panic了, 其执行被中断, 但是F中的延迟函数还是会正常执行, 然后F返回到调用它的地方.
在调用的地方, F行为就像调用了panic, 这个过程一直往上, 知道发生panic的goroutine中所有调用的函数返回, 此时程序退出

panic函数, 创建一个运行时错误, 并使程序终止
接受一个任意类型, 作为程序死亡时要打印的东西, 当编译器在函数结尾检查到panic是,就会停止进行常规的return语句检查

recover,
仅在延迟函数中有效, 当一切正常, 调用recover会返回nil, 没有其他任何效果
当goroutine陷入panic, recover可以捕获到panic的输入值, 并恢复正常执行


*/

type callFunc func()

func normal_func() {
	fmt.Println("It is just a normal func")
}

func get_panic() {
	panic("just panic")
}

func call_recover(f callFunc) (b bool) {
	defer func() {
		if x := recover(); x != nil {
			fmt.Println("error info:", x)
			b = true
		}
	}()
	f()
	return
}

func main() {

	a := call_recover(normal_func)
	fmt.Println("normal func", a)

	b := call_recover(get_panic)
	fmt.Println("panic func", b)

}
