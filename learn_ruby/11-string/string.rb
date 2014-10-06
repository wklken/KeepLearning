

# 创建 双引号转义, 单引号不转义
str1 = "string1"
p str1
str2 = 'string2'
p str2
str3 = "this is #{str1}"
p str3
str4 = 'this is #{str2}'
p str4

# 等价 "" 和 ''
desc = %Q{Ruby can use '' and  ""}
p desc
str = %q{Ruby say 'hello world'}
p str

# TODO: Here Document, <<-


#printf sprintf
n = 123
printf("%d\n", n)
printf("%4d\n", n)
printf("%04d\n", n)
printf("%0+d\n", n)
n = "Ruby"
printf("Hello, %s\n", n)
printf("Hello, %8s\n", n)
printf("Hello, %-8s\n", n)

# convert to string
p sprintf("%d", 123)

# 是否为空
p "".empty?
p "ruby".empty?

# 长度
p "ruby".size
p "ruby".length

# 字符数和字节数
p "中文".length
p "中文".bytesize

# 索引
s = "中文test"
p s[0]
p s[2]

# 连接字符串 - 生成新串
hello = "Hello,"
world = "World!"

str = hello + world
p str

# 修改原有
hello << world
p hello
hello.concat(world)
p hello

# 比较
p "aaa" == "bbb"
p "aaa" != "bbb"
p "a" < "b" #字典序/编码顺序

# 分割
str = "1:2:3:4"
p str.split(/:/)

# 删除多余换行符 chop删最后一个字符 chomp删换行符
str = "abcde"
p str.chop #=> "abcd"
p str.chomp #=> "abcde


# 检索
str = "ABBBBBBBBB"
p str.index("BB") #=> 1
p str.rindex("BB") #=> 8
p str.index("123") #=> nil

# 是否包含
p str.include?("BB")

# 与array相同的方法
# s[n] = str
# s[n..m] = str
# s[n, len] = str
# s.slice!(n)
# s.slice!(n..m)
# s.slice!(n, len)



# enumerator
# each_byte, each_line, each_char
str = "AA\nBB\nCC\n"
p str.each_line.map{|line| line.chomp} #=> ["AA", "BB", "CC"]
str.each_char do |cha|
  p cha
end

# strip strip!
p " Thank you.  ".strip

p "Object-Oriented Language".upcase
p "Object-Oriented Language".downcase
p "Object-Oriented Language".swapcase
p "Object-Oriented Language".capitalize

p "ABCDE".tr("BD", "bd")
