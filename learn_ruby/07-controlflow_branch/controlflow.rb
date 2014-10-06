

# 第一部分: 分支


################ if else

a = 20
if a >= 10 then
    print "bigger\n"
end

# 等价
puts "bigger" if a >= 10


# then可以省略
if a >= 10
    print "bigger\n"
end


if a >= 10
    print "bigger\n"
else
    print "smaller\n"
end

b = 20

if a > b
    puts "a > b"
elsif a < b
    puts "a < b"
else
    puts "a == b"
end



################ unless
unless a == b
    puts "a == b"
end

unless a == b
    puts "a == b"
else
    puts "a != b"
end


################ case
# 注意, case语句中, when判断是否相等使用的是 === 判断
# 当左边是数字或字符串, === 同 ==
# 除此之外, === 可以同 =~一样判断正则是否匹配
# 或者判断右边对象是否属于左边的类

tags = ["A", "IMG", "PRE"]
tags.each do |tag|
    case tag
    when "P", "A", "I", "B"
        puts "#{tag} has a child"
    when "IMG", "BR"
        puts "#{tag} has no child"
    else
        puts "#{tag}, cannot be used"
    end
end

array = ["a", 1, nil]
array.each do |item|
    case item
    when String   # String === item
        puts "item is a String."
    when Numeric
        puts "item is a Numeric."
    else
        puts "item is something"
    end
end

a = "ruby"

case a
when /Ruby/   # /Ruby/ =~ a
    puts "#{a} equals Ruby"
when /Ruby/i
    puts "#{a} equals Ruby or ruby"
else
    puts "#{a} not equals anything"
end



# 第二部分 循环

################ while

i = 1
while i <= 2 do
    print i, "\n"
    i = i + 1
end

# do可以省略
while i <= 2
    print i, "\n"
    i = i + 1
end

10.times do
    print "just for test\n"
end

