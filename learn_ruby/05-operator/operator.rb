

# 赋值运算符
a = 0
b = 1

a = a + 1
b = b + 2

a += 1
b += 2

# 逻辑运算符

var = nil
name = var || "ruby"

p name
arr = [1, 2]
a_value = arr && arr[0]
p a_value

var ||= 1
# 同
var = var || 1


# 条件运算符
a = 1
b = 2
v = (a>b) ? a : b
p v

# 范围运算符
p Range.new(1, 10)
p 1..10

for i in 1..3
  p i
end

p (1..10).to_a
p ("a".."f").to_a

# 自动生成下个值
v = "a"
v = v.succ
p v
v = v.succ
p v


# TODO: 查看下运算符优先级表.....


# TODO:运算符重定义
# 二元 + / -   def +(other) def -(other)
# 一元 +/-     def +@       def -@
