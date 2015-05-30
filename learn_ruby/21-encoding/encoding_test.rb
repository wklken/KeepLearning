# encoding: utf-8
 
a = "\u3042\u3044"
a.encode!("utf-8")
p a.encoding

# ------
# get the encoding of string
p "中文".encoding

b = "abc"
p b.encoding
c = b.encode("gbk")
p c.encoding  #=> gbk

# 防止错误, 在拼接字符串之前, 显示转为相同编码
# 检查是否可连接, 可以的话返回连接后的编码, 否则返回nil
p Encoding.compatible?("abc".encode("utf-8"), "中文".encode("gbk"))


# 查看支持的
p Encoding.list
p Encoding.name_list

# set encoding for write
# File.open("foo.txt", "w:UTF-8")




