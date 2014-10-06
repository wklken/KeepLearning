

a    = "abcdefg"
num  = 10
name = "ken"

p a
p num
print "name is ", name, "\n"

# 嵌入变量名
print "name is #{name}\n"


# 四种变量
# 局部变量: _ or 英文开头  -> 作用域无关, 不推荐, 在程序的任何地方都可以修改
# 全局变量: $开头          -> 作用域相关
# 实例变量: @开头
# 类变量: @@开头


$x = 1
x = 0

p $x
p x


# TODO: 注意不要用到ruby的保留字

# ======================

# 多重赋值,  左右结构基本一致
a, b, c = 1, 2, 3

p [a, b, c]

d, e, f = 4, 5
# f=>nil
p [d, e, f]

g, *h = 7, 8, 9
p [g, h]

i, *j, k = 10, 11, 12, 13
p [i, j, k]

# 交换变量值, 同python
a, b = 1, 2
a, b = b, a
p [a, b]


# 数组赋值
c, d = [3, [4, 5]]
p [c, d]


# 命名
# 变量名/方法名 sort_list_by_name
# 类名/模块名   sortListByName
