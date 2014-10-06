

# class
ary = []
str = "hello world"

p ary.class
p str.class

# TODO; ruby类继承图
# BasicObject -> Object -> Array/String/hash/Regexp/IO/Dir/Numeric/Exception/Time

# ==== 判断
p str.is_a?(String)
p str.is_a?(Object)

p str.instance_of?(String)
p str.instance_of?(Object)

# 创建
class HelloWorld

  attr_accessor :name #读写
  attr_reader :age #只读
  attr_writer :address #只写

  # initialize方法, new方法生成对象时, 被调用, 和python的__init__类似
  # new的参数会原封不动传过来
  # 参数可以指定默认参数
  def initialize(myname="Ruby", age=10, score=100, address="test") #initialize 方法
    # 初始化实例变量, 类似python的self.a = a
    @name = myname
    @age = age
    @score = score
    @address = address
  end


  def hello #实例方法
    # 引用了实例变量
    puts "Hello world, I am #{@name}"
  end

  # 存取器, 类似python的property => 可以被attr_reader/writer替代
  def name #获取
    @name
  end

  def name=(value) #设置
    @name = value
  end

  #
  def greet
    # 如果省略接受者, 会默认把self加上, 但是最好不省略吧
    # 因为不能以缺省的方式调用 name=方法
    puts "Hi, I am #{self.name}"
    puts "Hi, I am #{name}"
  end


end

bob = HelloWorld.new("Bob")
alice = HelloWorld.new("Alice")
ruby = HelloWorld.new

bob.hello
alice.hello
ruby.hello

p bob.name
bob.name = "Robert"
p bob.name

bob.greet

# 类方法

# 单例类 ruby2.1.2中不能执行, 奇怪 TODO
# class << HelloWorld2
  # def hello(name)
    # puts "#{name} said hello"
  # end
# end
# HelloWorld2.hello("Tom")


class HelloWorld3
  class << self
    def hello(name)
      puts "#{name} said hello"
    end
  end

  def HelloWorld3.greet(name)
    puts "#{name} said hello"
  end

end

HelloWorld3.hello("test")
HelloWorld3.greet("test2")


# 类中的常量

class HelloWorld4
  Version = "1.0"
end
p HelloWorld4::Version

# 类变量

class HelloCount
  @@count = 0

  def HelloCount.count
    @@count
  end

  def initialize(myname="Ruby")
    @name = myname
  end

  def hello
    @@count += 1
    puts "hello world, I am #{@name}\n"
  end
end

bob = HelloCount.new("Bob")
alice = HelloCount.new("Alice")
ruby = HelloCount.new

p HelloCount.count
bob.hello()
alice.hello()
ruby.hello()
p HelloCount.count

# 限制方法调用
# public 公开
# private 在指定接收者的情况下不能调用(只能使用缺省接收者的方式调用该方法, 因此无法从实例的外部访问 )
# protected 同一个类中时, 可将方法作为实例方法调用

class AccTest

  def pub
    puts "pub is a public method."
  end
  public :pub

  def priv *args
    puts "priv is a private method."
  end

  private :priv
end

acc = AccTest.new
acc.pub
# acc.priv #报错

class AccTest2

  public #不指定参数时, 后面跟的方法都是public
  def pub
    puts "pub is a public method."
  end

  private
  def priv *args
    puts "priv is a private method."
  end

end

# 注意: 没有指定访问级别默认方法位public, initialize方法除外默认是private

# protected, 在同一个类及其子类可作为实例方法使用, 其他地方没法用

class Point
  attr_accessor :x, :y
  protected :x=, :y=

  def initialize(x=0.0, y=0.0)
    @x, @y = x, y
  end

  def swap(other)
    tmp_x, tmp_y = @x, @y
    @x, @y = other.x, other.y
    other.x, other.y = tmp_x, tmp_y

    return self
  end
end


p0 = Point.new
p1 = Point.new(1.0, 2.0)
p [p0.x, p0.y]
p [p1.x, p1.y]

p0.swap(p1)
p [p0.x, p0.y]
p [p1.x, p1.y]

# p0.x = 10.0 #报错


# ============== 直接在原有类上增加方法

class String
  def count_word
    self.split(/\s+/).size
  end
end

p "Just one word".count_word

# ============== 继承
class RingArray < Array
  def [](i)
    idx = i % size
    super(idx) #调用父类同名方法
  end
end

w = RingArray[1,2,3,4,5,6]
p w[7]
p w[8]

# 定义类的时候, 没有指定父类, 则默认使用Object
# 可以使用BasicObject, 最低限度的方法
p Object.instance_methods
p BasicObject.instance_methods


# ============== 给方法设定别名

class C1
  def hello
    "hello"
  end
end

class C2 < C1
  alias old_hello hello
  def hello
    "#{old_hello}, again"
  end
end

obj = C2.new
p obj.old_hello
p obj.hello

# ============== 删除已有的方法定义, 在子类中删除父类定义的方法
# undef functionname
# undef :functionname






