
# 简单示例

[1, 2, 3, 4, 5].each do |i|
  puts i ** 2
end

# obj.func(args) do |vari|
#   dosomething
# end

# obj.func(args {|vari| dosomething }

# 使用: 1. 循环

alphabet = ["a", "b", "c", "d", "e"]
alphabet.each do |i|
  puts i.upcase
end

sum = 0
outcome = {:a => 100, :b => 200}
outcome.each do |pair|
  sum += pair[1]
end
puts "sum: #{sum}"

sum = 0
outcome.each do |item, price|
  sum += price
end
puts "sum #{sum}"

# 使用: 2. 隐藏常规处理

# 退出前关闭文件
begin
  File.open("sample.txt") do |file|
    file.each_line do |line|
      print line
    end
  end
rescue => ex
  p ex.message
end

# 使用: 3.替换部分算法

array = %w(ruby Perl PHP Python)
#sorted = array.sort
sorted = array.sort{|a, b| a <=> b}
p sorted

# length会被反复调用
sorted = array.sort{|a, b| a.length <=> b.length}
p sorted

# 只调用一次
sorted = array.sort_by{ |item| item.length }
p sorted


#======================= 定义块

def myloop
  while true
    yield #关键字作用域就是执行方法的块
  end
end

num = 1
myloop do
  puts "num is #{num}"
  break if num > 10
  num *= 2
end


# 给块传递参数

def total(from, to)
  result = 0
  from.upto(to) do |num|
    if block_given? # 如果有块的话
      result += yield(num) #=> to block
    else
      result += num
    end
  end

  return result
end

p total(1, 10)
p total(1, 10){|n| n**2}

# 参数的接收

def block_args_test
  yield() #0个块变量
  yield(1)
  yield(1, 2, 3)
end

puts "|a| recevie"
block_args_test do |a|
  p [a]
end

puts "|a, b, c| receive"
block_args_test do |a, b, c|
  p [a, b, c]
end

puts "|*a| receive"
block_args_test do |*a|
  p [a]
end


# ====== another eg

hash = {a:100, b:200, c:300}
hash.each_with_index do |(key, value), index|
  p [key, value, index]
end

#============  控制块的执行
# break 会马上返回到调用块的地方
# next 程序终端当前处理, 并继续执行下面的处理. 使用next后, yield返回, 如果next没有带任何参数则返回nil
# 如果指定参数, 返回参数
#
# redo 程序返回块开头, 并按照相同的块变量再次执行处理, 可能陷入死循环, 谨慎处理

n = total(1, 10) do |number|
  if number == 5
    break
  end
  number
end

p n #=> nil

n = total(1, 10) do |number|
  if number % 2 != 0
    next 0
  end
  number
end

p n


# ============== 将块封装成对象

hello = Proc.new do |name|
  puts "hello #{name}"
end

hello.call("World")
hello.call("Ruby")


def call_each(ary, &block)
  ary.each(&block)
end

call_each [1, 2, 3] do |item|
  p item
end

# ==============局部变量与块变量

# 块内部的命名空间与块外部是共享的, 在块外部定义的局部变量, 在块中也可以继续使用
# 快变量, 即使存在外部同名变量, ruby也会认为是两个不同的变量

x = 1
y = 1
ary = [1, 2, 3]

ary.each do |x|
  y = x # 这里x是块变量, 每次不一样  作用域仅限于此
end
p [x, y]



