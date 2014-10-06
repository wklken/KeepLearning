
# base
# create
names = ["Ken", "Tom", "Ruby"]
print names, "\n"

print names[0], "\n"

names[1] = "Luna"

print names, "\n"

# Array.new
a = Array.new
p a #=> [
a = Array.new(5)
p a #=> [nil, nil, nil, nil, nil]
a = Array.new(5, 0)
p a #=> [0, 0, 0, 0, 0]

# special: 字符串数组   nice
lang = %w(hello world hello ruby)
p lang #=> ["hello", "world", "hello", "ruby"]

# special: symbol
lang = %i(hello world)
p lang #=> [:hello, :world]


# 索引, 类似python, 只是: -> ..
alpha = %w(a b c d e f g)
p alpha[0] #=> "a"
p alpha[-1] #=> "g"
p alpha[1..3] #=> ["b", "c", "d"]
p alpha[1..100] #=> ["b", "c", "d", "e", "f", "g"]
p alpha[2, 3] #=> ["c", "d", "e"]

# 等价的
p alpha.at(0)
p alpha.slice(0)
p alpha.slice(-1)
p alpha.slice(1..3)
p alpha.slice(1..100)
p alpha.slice(2, 3)

# 赋值
alpha[1] = 'B'
p alpha
alpha[2..4] = ["C", "D", "E"]
p alpha
alpha[5,7] = ["F", "G", "H"]
p alpha

# 插入, 等价于对0个元素赋值
alpha[2, 0] = ["X", "Y"]
p alpha

# 通过索引创建新的数组
p alpha.values_at(1, 3, 5)

# 类似队列操作
# PS: 才发现, 一个函数如果没参数的话, 目测() 可以不写....好处省事, 坏处怎么判断是属性还是方法来的>
queue = [1, 2, 3]
p queue
queue.push(4)
p queue
r = queue.shift
p "shift #{r}"
p queue

# 类似栈的操作
stack = [1, 2, 3]
p stack
stack.push(4)
p queue
r = stack.pop()
p "pop #{r}"
p stack
p "first #{stack.first}"
p "last #{stack.last}"

# 加入到数组头
arr = [1, 2, 3]
p arr
arr.unshift(0)
p arr

# 加入到数组尾a, 等价push
arr << 4
p arr

# 连接数组
arr.concat([8, 9])
p arr
arr += [10]
p arr

# 从数组中删除所有nil元素
p [1, nil, 2, 3, nil].compact
p [1, nil, 2, 3, nil].compact!
p [1, 2, 3,].compact! #什么都没删除返回nil

# 从数组中删除value元素
a = [1, 2, 3, 2, 1]
p a
p a.delete(2) # 修改原数组, 返回删除的个数
p a
a = [1, 2, 3, 4]
p a.delete_at(0)
p a

# 删除元素, 满足某些条件
a = [1, 2, 3, 4, 5]
p a
a.delete_if{|i| i>3}
p a

a = [1, 2, 3, 4, 5]
p a
p a.reject{|i| i> 3} #返回新的数组, 原数组不变
p a
p a.reject{|i| i> 10} #条件全部不符合不会有问题

a = [1, 2, 3, 4, 5]
p a.reject!{|i| i > 10} # 条件不符合返回nil
p a

# 切片, 会影响到原数组, !   这里和python不一样
# slice!(n)  slice!(n..m) slice!(n, len)
a = [1, 2, 3, 4, 5]
p a.slice!(1, 2) #=>[2,3]
p a #=> [1, 4, 5]
p a.slice!(10, 2) #=>nil
p a #=> [1, 4, 5]

# 删除重复元素
a = [1, 2, 3, 4, 5, 4, 3]
p a.uniq #=> 返回新的, 不会修改原数组
p a

a = [1, 2, 3, 4, 5, 4, 3]
p a.uniq! #=> [1,2,3,4,5]
p a
a = [1, 2, 3]
p a.uniq! #=> nil
p a



# size
print "array size:", names.size

# other type
num = [3, 1, 4, 2, 5]
puts num
mixed = [1, "test", 2]
puts mixed

# loop

names.each do |n|
    puts n
end

# convert : dict -> array
table = {black: 1, white:2}
p table.to_a

# string -> array
p "hello ruby".split()

# 两个array 相加
odd = [1, 3, 5]
env = [2, 4, 6]
p odd + env

# 作为集合
arr1 = %w(a b c)
arr2 = %w(b c d)
p (arr1 & arr2) #=> ["b", "c"]
p (arr1 | arr2) #=> ["a", "b", "c", "d"]
p (arr1 - arr2) #=> ["a"]

# 替换数组元素
# a.collect/collect!/map/map!
a = [1, 2, 3, 4, 5]
a.collect!{|item| item*2}
p a #=> [2, 4, 6, 8, 10]
a.map!{|item| item/2}
p a #=> [1, 2, 3, 4, 5]

# fill(v) fill(v, begin) fill(v, begin, len) fill(v, n..m)
p [1, 2, 3, 4, 5].fill(0) #=> [0, 0, 0, 0, 0]
p [1, 2, 3, 4, 5].fill(0, 2) #=> [1, 2, 0, 0, 0]
p [1, 2, 3, 4, 5].fill(0, 2, 2) #=> [1, 2, 0, 0, 5]
p [1, 2, 3, 4, 5].fill(0, 2..3) #=> [1, 2, 0, 0, 5]

# flatten flatten!, 嵌套数组展开
a = [1, [2, [3]], [4], 5]
a.flatten!
p a #=>[1, 2, 3, 4, 5]

# reverse 反转
a = [1, 2, 3, 4, 5]
a.reverse!
p a #=> [5, 4, 3, 2, 1]

# 排序 sort/sort! sort{|i, j|} sort!{|i, j|}
a = [2, 4, 3, 5, 1]
a.sort!
p a #=> [1, 2, 3, 4, 5]

a = [2, 4, 3, 5, 1]
p a.sort_by{|i| -i} #=> [5, 4, 3, 2, 1]

# 遍历
a = [1, 2, 3]
for i in 0..2
  print "#{i} - #{a[i]}\n"
end

a.each do |elem|
  p elem
end

a.each_with_index do |elem,index|
  print "#{index} - #{elem}\n"
end

# 二维数组初始化
a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
p a
a = Array.new(3) do
  [0, 0, 0]
end
p a

a = Array.new(5) {|ii| ii+1}
p a


# 同时访问多个数组
arr1 = [1,  2,   3]
arr2 = [10, 20,  30]
arr3 = [100,  200, 300]

result = []
arr1.zip(arr2, arr3) do |a, b, c|
  result << a+b+c
end
p result
