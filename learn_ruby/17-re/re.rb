

# nil, 特殊对象值, 表示对象不存在

puts (/Ruby/ =~ "Ruby")
puts (/Ruby/ =~ "ruby") #=> nil

# 忽略大小写
puts (/Ruby/i =~ "ruby") #=> nil


# str -> re对象

r = Regexp.new("Ruby")
p r

# 特殊语法
# %r()
# %r<>
# %r||
# %r!!

# 正则选项
# i 忽略大小写
# x 忽略正则中的空白字符以及#后面的字符选项
# m 可匹配多行

str = "ABC\nDEF\nGHI"
p (/DEF.GHI/ =~ str)
p (/DEF.GHI/m =~ str)

# ====== 捕获
/(.)(.)(.)/ =~ "abc"
p $1, $2, $3

# 注意这里 1 45 6
/(.)(\d\d)+(.)/ =~ "123456"
p $1, $2, $3

# 过滤掉不需要捕获的
/(.)(?:\d\d)+(.)/ =~ "123456"
p $1, $2

/C./ =~ "ABCDEF"
p $` #前
p $& # 匹配
p $' #后


# ============== sub/gsub

str = "abc    def  g  hi"
p str.sub(/\s+/, ' ') #第一个
p str.gsub(/\s+/, ' ') #所有匹配位置

str = "abracatabra"
nstr = str.sub(/.a/) do |matched|
  '<' + matched.upcase + '>'
end
p nstr

nstr = str.gsub(/.a/) do |matched|
  '<' + matched.upcase + '>'
end
p nstr

# ============= scan

"abracatabra".scan(/.a/) do |matched|
  p matched
end

"abracatabra".scan(/(.)a/) do |matched|
  p matched
end

"abracatabra".scan(/(.)(a)/) do |matched|
  p matched
end

"abracatabra".scan(/(.)(a)/) do |a, b|
  p a + '-' + b
end



