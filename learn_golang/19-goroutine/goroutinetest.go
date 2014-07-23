package main

import (
	"fmt"
	"runtime"
)

/*
goroutine是Go语言并行涉及的核心

说到底是线程, 但是比线程更轻.(轻量级线程实现)

goroutine之间共享内存, 执行goroutine只需极少的栈内存

比thread更易用, 更轻量, 更高效

goroutine 是通过Go语言的runtime管理的一个线程管理器, 通过go关键字实现

很方便实现了并发编程, 不过设计上我们要遵循, 不要通过共享来通信, 要通过通信来共享


默认情况下, 调度器只使用单线程, 即只实现了并发
想要发挥多核处理器的并行, 需要显示调用runtime.GOMAXPROCS(n)

---------------

goroutine 之间如何进行通信?
使用channel

可以通过channel发送或者接受值, 这些值只能是特定类型, 定义时就确定了类型

必须使用make创建channel

ci := make(chan int)
cs := make(chan string)
cf := make(chan interface{})

发送
ch <- v

接受
v := <-ch

默认情况下, channel接收和发送数据都是阻塞的
如果 value := <-ch , 被阻塞, 直到有数据接收
另外  任何   ch <- value将被阻塞, 知道数据被读取

-------------

buffered channel
允许指定channel的缓冲大小
ch:=make(chan bool, 4) 前四个元素可以无阻塞写, 写入第五个元素时, 阻塞, 知道其他goroutine从channel中读取一些元素腾出空间


ch := make(chan type, value)
value ==0 无缓冲, 阻塞
value >0 缓冲, 非阻塞, 直到有value个元素

-------------


使用range和close, 操作channel
记住应该在生产的地方close,而不是消费的地方

-------------
select
可以监听多个channel上的数据

-------------

var ch1 chan int //正常
var ch2 chan<- float64 //单向,用于写
var ch3 <-chan int //单向, 只用于读

-------------

runtime goroutine几个处理函数
Goexit 退出
Gosched 让出当前goroutine的执行权限, 下次某个时候从该位置恢复
NumCPU cpu核数
NumGoroutine 正在执行和排队的任务总数
GOMAXPROCS 用于设置cpu核数


--------------
如何处理超时?

    select {
        case <-time.After(5*time.Second)
    }



*/

func say(s string) {
	for i := 0; i < 5; i++ {
		runtime.Gosched() //出让时间片
		fmt.Println(s)
	}
}

// 使用chan

func sum(a []int, c chan int) {
	sum := 0
	for _, v := range a {
		sum += v
	}
	c <- sum
}

// range/close
func fibonacci(n int, c chan int) {
	x, y := 1, 1
	for i := 0; i < n; i++ {
		c <- x
		x, y = y, x+y
	}
	close(c) //注意这里
}

// for select
func fibonacci2(c, quit chan int) {
	x, y := 1, 1

	for {
		select {
		case c <- x:
			x, y = y, x+y
		case <-quit:
			fmt.Println("exit")
			return
		}
	}
}

func main() {

	go say("world") //开一个新的Goroutines执行
	say("hello")    //当前goroutines执行

	a := []int{1, 2, 3, 4, 5}

	c := make(chan int)
	go sum(a[:len(a)/2], c)
	go sum(a[len(a)/2:], c)
	x, y := <-c, <-c

	fmt.Println(x, y, x+y)

	ch := make(chan int, 2)
	ch <- 1
	ch <- 2
	//ch <- 3 //解开注释报错
	fmt.Println(<-ch)
	fmt.Println(<-ch)

	//--------------
	ci := make(chan int, 10)
	go fibonacci(cap(ci), ci)
	// 不断读取channel里面数据, 直到channel被关闭
	for i := range ci {
		fmt.Println(i)
	}

	// 检测是否关闭
	_, ok := <-ci
	if ok {
		fmt.Println("ci is not closed")
	} else {
		fmt.Println("ci is closed")
	}

	fmt.Println("test select")
	// select
	c2 := make(chan int)
	quit := make(chan int)
	go func() {
		for i := 0; i < 10; i++ {
			fmt.Println(<-c2)
		}
		quit <- 0
	}()

	fibonacci2(c2, quit)

}
