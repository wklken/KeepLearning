
# Mix-in
# 虽然两个类拥有相似的功能, 但是不希望把它们作为相同的种类(Class)
# Ruby不支持多重继承, 因此无法对已经继承的类添加共通的功能


# Module是既定存在的实体定义, 和Python的module概念不同
module HelloModule
  Version = "1.0"

  def hello(name)
    puts "Hello #{name}"
  end

  module_function :hello #指定hello作为模块函数
end

p HelloModule::Version
HelloModule.hello("Alice")

include HelloModule
p Version
hello("Alice")

# ============================= Mix-in

module M
  def meth
    "meth"
  end
end

class C
  # 虽然不是父类, 却起着父类的作用
  include M #包含M模块
end

c = C.new
p c.meth

# 继承关系
p C.ancestors
p C.superclass

# 通过Mix-in, 可以保持单一继承关系, 又可以同时让多个类共享其他功能


# mix-in 查找方法顺序
# 1. 原类中已经定义了同名方法, 使用该方法
# 2. 同一个类中包含多个模块, 优先使用最后一个包含的模块
# 3. 嵌套include时, 查找循序也是线性的

module M1
end
module M2
end
module M3
  include M2
end

class C1
  include M1
  include M3
end

p C1.ancestors # [C1, M3, M2, M1, Object, HelloModule, Kernel, BasicObject]

# 4. 相同模块引用两次, 第二次以后的会被省略

class C2
  include M1
  include M2
  include M1
end
p C2.ancestors # [C2, M2, M1, Object, HelloModule, Kernel, BasicObject]

# ====================== 将模块功能扩展到对象中

module Edition
  def edition(n)
    "#{self} version: #{n}"
  end
end

str = "Ruby"
str.extend(Edition)
p str.edition(4)

# =============== 类与Mix-in

module ClassMethods
  def cmethod
    "class method"
  end
end

module InstanceMethods
  def imethod
    "instance metho"
  end
end

class MyClass
  # extend 定义类方法
  extend ClassMethods
  # include 实例方法
  include InstanceMethods
end

p MyClass.cmethod
p MyClass.new.imethod

