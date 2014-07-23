




make 用于呢件类型的内存分配  slice , map, channel
make只能创建slice/map/channel 并且返回一个有初始值(非零) 的 T 类型, 而不是*T (指向数据结构的引用在使用前必须初始化)
make返回初始化后的非零值

new 用于各种类型的内存分配
new 返回指针 new(T) 分配了零值填充的T类型的内存空间, 并返回其地址, 即一个*T类型的值



---------------


goto

善用, goto跳转到必须在当前函数内定义的标签

    func myFunc() {
        i := 0
    Here:
        println(i)
        i++
        goto Here
    }

---------------
