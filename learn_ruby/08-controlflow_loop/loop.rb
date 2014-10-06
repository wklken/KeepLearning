
# 六种循环
# times/while/each/for/until/loop ....尼玛

#======== times

2.times do
    puts "loop twice"
end

2.times do |i|
    puts "loop:", i
end

#======== for

sum = 0

for i in 1..5
    sum = sum + i
end
puts sum

# 这个和python很像
names = ["ken", "tom", "juno"]
for name in names
    puts name
end

#======== each

sum = 0
(10..12).each do |inc|
    sum += i
    puts "add: #{inc}"
end
puts  sum

# 等价for in
names = ["ken", "tom", "juno"]
names.each do |n|
    puts n
end


#======== while

i = 1
while i < 3
    puts i
    i += 1
end

#======== until
sum = 0
i = 1
until sum > 5
    sum += 1
    i += 1
end
puts sum

#======== loop

# loop do
    # puts "loop forever"
# end

#================ break / next /redo
# break 终止程序跳出循环
# next 跳到下一次循环, 同continue
# redo 在相同条件下重复刚才的处理

index = 0
p names
names.each do |one_name|
    index += 1
    if index == 2 #第二次再进来条件不符合了
        p "redo it"
        redo
    end
    p [index, one_name]
end


# tip
# 程序跨行写, 使用do-end
# 在1行的时候, {}
2.times {|count| puts count}

