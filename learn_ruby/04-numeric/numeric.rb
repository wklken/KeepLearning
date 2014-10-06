

# Numeric
# Integer(Fixnum普通整数/Bignum大整数) / Float / Rational 有理数 / Complex 复数


n = 2 * 100
p n.class

m = 2 ** 1000
p m.class


a = Rational(2, 5)
p a
p a.to_f

c = Complex(0, 2) ** 2
p c

# 字面值
p 123456

p 1_234_56 # _会被自动忽略
p 0b11111 # 二进制
p 01234567 # 八进制
p 0x12345678 #十六进制

p 1.234
p 1.234e4 #12340
p 1234e-4 #0.1234

# 算术 + = * /
# % ** 求余和乘方

p 5 / 2 #=> 2
p 5 / 2.0 #=> 2.5


# x/y之后商的整数
p 5.div(2) #=>2
p 5.div(2.2) #=>2

# x/y之后的商, 如果x/y都是整数, 然会Rational对象
p 5.quo(2) #=>5/2
p 5.quo(2.2) #=>2.72....

# x % y
p 5.modulo(2)

# 商和余数
p 10.divmod(3.5) #=> [2, 3.0]

# x/y的余数, 符号同x
p 10.remainder(3.5)

# p 1/0 # error
p 1/0.0 # Infinity
p 0/0.0 # NaN


#================== math模块

p Math.sqrt(2)

#=========== 数值转换

# to_f
p 10.to_f
p 19.8.to_f
p "12.3".to_f

p 10.8.to_i
p (-10.8).to_i
p "123".to_i

# 四舍五入
p 1.2.round
p 1.8.round

# ceil/floor
p 1.5.ceil
p (-1.5).ceil
p 1.5.floor
p (-1.5).floor

# to_r to_c
p 1.5.to_r
p 1.5.to_c

# 位运算
# ~按位取反 & | ^异或 >> <<

def pb(i)
  printf("%08b\n", i & 0b11111111)
end

b = 0b11110000

pb(b)
pb(~b)
pb(b & 0b00010001)
pb(b >> 3)

#================= 随机数
p Random.rand
p Random.rand(100)

# 同
r1 = Random.new(1)
p [r1.rand, r1.rand]
r2 = Random.new(1)
p [r2.rand, r2.rand]

# 不同
r1 = Random.new()
p [r1.rand, r1.rand]
r2 = Random.new()
p [r2.rand, r2.rand]

#================= 计数
ary = []
3.times do |i|
  ary << i
end
p ary

ary = []
2.upto(10) do |i|
  ary << i
end
p ary

ary = []
10.downto(2) do |i|
  ary << i
end
p ary

ary = []
2.step(10, 3) do |i| # 2-> 10 , step=3
  ary << i
end
p ary

# TODO: bigdecimal


# Comparable模块, Min-in到类, 实现具体方法



