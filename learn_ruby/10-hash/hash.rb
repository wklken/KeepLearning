

# 符号symbol, 也是对象, 一般作为名称标签来使用, 用来表示方法等的对象的名称

# 等价的两个声明
sym = :foo
sym2 = :"foo"
puts sym, sym2

# 转字符串
sym.to_s

# 转符号
"foo".to_sym


# 创建create

person = {:name => "tom", :age => 18, }

puts person
puts person[:name]

person[:tel] = "010-111111"
puts person

# 使用Hash.new
h1 = Hash.new
h2 = Hash.new("") #=> default return
p h1["not_key"] #=>nil
p h2["not_key"] #=>""

# 获取和设定值
h = Hash.new
h["R"] = "Ruby"
p h["R"]

h.store("P", "python")
p h.fetch("P")
# p h.fetch("not_key") #当key不存在, 异常
p h.fetch("not_key", "default") #当key不存在, 指定default

# fetch还可以使用块
h = Hash.new
p h.fetch("N") { String.new} #=> ""

# 一次性获取所有key/value
h = {"a" => 1, "b" => 2}
p h.keys
p h.values
p h.to_a
h.each_key do |key|
  p key
end

h.each_value do |value|
  p value
end

h.each_pair do |key,value|
  p [key, value]
end

# 通过块指定默认值
h = Hash.new do |hash, key|
  hash[key] = key.upcase
end
p h["x"] # do insert
p h

p h.fetch("y", "default") # no insert
p h

#=====================
## 包含

h = {"a" => 1, "b" => 2}
p h.key?("a")
p h.has_key?("a")
p h.include?("z")
p h.member?("z")

p h.value?(3)
p h.has_value?(1)


#=====================

#  大小
p h.size
p h.length

p h.empty?

# 删除键值
h = {"a" => 1, "b" => 2}
h.delete("a")
p h
h.delete("not_key")
p h
p h.delete("not_key") {|key| "not exists #{key}"}

h = {"a" => 1, "b" => 2}
p h.delete_if{|key, value| key == "a"} #返回原来散列
p h.reject!{|key, value| key == "l"} #nil

#=====================

# 初始化散列

h = {"a" => 1, "b" => 2}
h.clear
p h.size

# 嵌套
table = {"A" => {"a"=>1, "b"=>2},
         "B" => {"a"=>3, "b"=>4}}
p table["A"]["a"]

#=====================

# loop

person.each do |key, value|
    puts "#{key}: #{value}"
end


