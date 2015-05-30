


# now
p Time.new
# sleep 1
p Time.now

# year/month/day
t = Time.now
p t.year
p t.month
p t.day

p t.hour
p t.min
p t.sec

# 计算
t1 = Time.now
t2 = t1 + 60*60

p t1 < t2
p t2 - t1

# format
t3 = Time.now
p t3.to_s
p t3.strftime("%Y-%m-%d %H:%M:%S")

# local and utc
t4 = Time.now
p t4
t4.utc
p t4
t4.localtime
p t4


# from string
require "time"
p Time.parse("2015-05-30")
p Time.parse("2015-05-30 00:12:33")

# =================  date ====================
require "date"
d = Date.today
p d
puts d

p d.year
p d.month
p d.day

d2 = Date.new(2013, 3, 30)
puts d2

# last day of month
puts Date.new(2013, 2, -1)

# 计算
puts Date.new(2013, 1, 4) - Date.new(2013, 1, 1) #3/1 三天

# 上月下月相同日期
d3 = Date.today
puts d3
puts d3 >> 1
puts d3 << 1


# 格式
d4 = Date.today
p d4.strftime("%Y/%m/%d")

p d4.to_s

# string to date
puts Date.parse("2013-01-01")

