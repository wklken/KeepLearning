
# File.open(file, mode)
# mode:
# r 只读方式打开
# r+ 读写
# w 只写, 无论如何变成新文件
# w+ 读写模式, 其余同w
# a 追加模式, 不存在则创建新
# a+ 读取/追加模式

# read all
filename = "test.txt"
f = File.open(filename)
text = f.read
print text
f.close()

data = File.read(filename)
print data


# read lines
f2 = File.open(filename)
f2.each do |line|
    print line
end
f2.close()

p f2.closed?




############
# 读取 - io.gets

# 同python的with
File.open(filename) do |io|
  while line = io.gets
    print line
  end
end

# 读取 - io.each
f3 = File.open(filename)
f3.each_line do |line|
  line.chomp!
  print line
end
f3.close()
# lineno
f4 = File.open(filename)
f4.each_line do |line|
  print printf("%3d - %s", f4.lineno, line)
end
f4.close()

# 读取 - io.each_line
# 读取 - io.readlines

# io.each_char
# io.each_byte
#
# io.getc
# io.ungetc(ch)  将
#
# io.getbyte
# io.ungetbyte(byte

# io.read(size) 读取指定大小

# =========================
# output   io.xxx

$stdout.puts("hello", "ruby")

$stdout.putc(82)
$stdout.putc("Python")
$stdout.putc("\n")

$stdout.print("hello", "ruby", "\n")
$stdout.printf("hello %s\n", "ruby")

size = $stdout.write("hello\n")
p size

$stdout << "foo" << "bar" << "baz"

# =========================
# pointer
File.open(filename) do |io|
  p io.read(5)
  p io.pos
  io.pos = 0
  p io.gets
end

# TODO: io.seek(offset, whence

File.open(filename) do |io|
  p io.gets
  io.rewind
  p io.gets
end

# io.truncate(0) 文件清空
# io.truncate(io.pos) 删除当前指针以后的

# 变更为二进制模式
File.open(filename, 'w') do |io|
  io.binmode
  io.write("Hello, world.\n")
end


$stdout.print "out1"
$stdout.print "out2"
$stdout.print "out3"
$stdout.print "out4"
$stdout.flush
$stdout.print "out5"
$stdout.print "\n"

$stdout.sync = true # 同步输出处理
$stdout.print "hi"

# TODO: 命令行交互, IO.popen()




