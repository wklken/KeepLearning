

# 使块对象化的类

hello = Proc.new do |name|
  puts "Hello, #{name}"
end

hello.call("tom")


judge = Proc.new do |x|
  x > 10
end

p judge.call(0)
p judge.call(20)
p judge[200]


# lambda 1.参数校验更严格 2.可以使用return
lp = lambda do |a, b, c|
  p [a, b, c]
end

lp.call(1, 2, 3)


def power_of(n)
  lambda do |x|
    return x ** n
  end
end

cube = power_of(3)
p cube.call(2)



