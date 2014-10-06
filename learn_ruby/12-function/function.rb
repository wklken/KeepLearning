
# call function
# 一般方法调用
# obj.functionname(arg1, arg2, ...)
#
# 带块的方法调用 each...
# 1 可以省略参数
# obj.funcname(args, ...) do |var1, var2, ...|
# dosomething
# end

# 2
# obj.funcname(arg, ...) {|var1, var2...|
#   do something
# }


# PS:...刚看到建议缩进2空格, 习惯用4个会不会被打>_<||
# 写一半了怎么破, vim改下就成, 但是风格不一致了...


# 简单方法

def hello
  print "Hello, Ruby\n"
end

def say_hello(name)
  puts "Hello, #{name}"
end

def say_hello2(name="Ruby")
  puts "Hello, #{name}"
end

hello()
say_hello("Ruby")
say_hello2()


# 返回值

def volume(x, y, z)
  return x * y * z
end

p volume(2, 3, 4)

# 省略return, 会返回最后一个表达式的值, cool
def volume2(x, y, z)
  x * y * z
end

p volume2(2, 3, 4)
xyz = [2, 3, 4]
p volume2(*xyz) #数组作为参数, * unpack

def max(a, b)
  if a > b
    a
  else
    b
  end
end

p max(1, 2)

# 定义带块的方法

def myloop
  while true
    yield #执行块
  end
end

num = 1
myloop do
  puts "num is #{num}"
  break if num > 16 # 妈蛋...可以这么用啊
  num *= 2
end

# 参数不确定

def foo(*args)
  args
end

p foo(1, 2, 3)

def meth(arg, *args)
  [arg, args]
end

p meth(1)
p meth(1, 2, 3)

# 不同于python, 可以放中间
def boo(a, *b, c)
  [a, b, c]
end

p boo(1, 2, 3, 4, 5)

# 关键字参数

def area2(x:0, y:0, z:0)
  (x*y + y*z + z*x) * 2
end

p area2(x:2, y:3, z:4)
p area2(x:2, y:3)

args1 = {x:2, y:3, z:4}
p area2(args1) # dict传参 ,  TODO: no need unpack?

# 普通参数+ 关键字参数

def func(a, b:1, c:2)
  [a, b, c]
end

#p func(1, 2, 3) wrong, 这里和python 不一样
p func(1, b:2, c:3)

