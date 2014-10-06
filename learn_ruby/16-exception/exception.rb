
# 异常处理

# begin
#   dosomething
# rescue
#   handling with exceptions
# end

# rescue => 异常对象变量

def foo
  File.open("/no/file")
end

# 对于这种连 return/冒号 都能省的方式,表示很赞...

def bar
  foo()
end

begin
  bar()
rescue => ex
  print ex.message, "\n"
end

#=============== ensure

def copy(from, to)
  src = File.open(from)
  begin
    dst = File.open(to, "w")
    data = src.read
    dst.write(data)
    dst.close
  ensure
    src.close
  end
end

#=============== retry 会进行重试

file = ARGV[0]
io = nil
begin
  io = File.open(file)
rescue
  sleep 10
  # retry # 会一直重试....
end

if io
  data = io.read
  p data
  io.close
end

# rescure修饰符

val = "abc"

n = Integer(val) rescue 0
p n #=> 0

#===========================

# 捕获异常的范围是整个方法体
# TODO: 返回值怎么处理的?
def foo
  p "abc"
rescue => ex
  p ex.message, "\n"
ensure
  p "finally"
end

# 整个类定义, 如果发生异常, 异常部分后的方法定义就不再执行了
class Foo
rescue => ex
  p ex.message, "\n"
ensure
  p "finally"
end

#==========================

# 指定要捕获的异常

file1 = ARGV[0]
file2 = ARGV[1]
begin
  io = File.open(file1)
rescue  Errno::ENOENT, Errno::EACCES
  io = File.open(file2)
end


# TODO: 异常类关系图

# 新建异常类
MyError = Class.new(StandardError)

MyError1 = Class.new(MyError)
MyError2 = Class.new(MyError)

class MyError3 < StandardError
end

#=========================

# 主动抛出异常

# raise message
# raise ExceptionClass
# raise ExceptionClass, message
# raise


