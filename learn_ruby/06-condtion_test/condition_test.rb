# 条件测试

# 真值true/false

# 真, 除false/nil以外的所有对象 -> 0也是真, 区别于python
# 假, false/nil

p 1 == 1
p 1 != 1
p 1 > 2
p 1 >= 2
p 1 < 2
p 1 <= 2

# 注意, 所有返回 true/false 的方法, 以?结束
p "".empty?
p "A".empty?
p ("Ruby" == "Rubens")

p (/Ruby/ =~ "ruby") #=> 0
p (/Ruby/i =~ "ruby") #=> nil


p !nil #=> true, nil is flase
a = 0
p !a #=> false, 0 is true


# 逻辑运算符
# and or not

x = 1
if x > 0 && x < 10
    p "test and "
end

if x > 0 || x < 5
    p "text or "
end


if !x
    p "x is not true"
else
    p "x is true"
end

# 对象的同一性

# equal? 判断两个对象是否是同一个对象
# eql? 判断值是否相等, 更严格
# ==, 判断之是否相等, 不严格

str1 = "foo"
str2 = str1
str3 = "f" + "o" + "o"
p str1.equal?(str2) #=> true
p str1.equal?(str3) #=> false

p str1.eql?(str2) #=> true
p str1.eql?(str3) #=> true
p str1 == str3

p 1.0 == 1 #=> true
p 1.0.eql?(1) #=> false
