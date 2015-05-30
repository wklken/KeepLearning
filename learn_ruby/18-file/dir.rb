
# file ops
# require "file"
# rename
File.rename("test2.txt", "test3.txt")
File.rename("test3.txt", "test2.txt")


require "fileutils"

FileUtils.cp("test2.txt", "test4.txt")
File.delete("test4.txt")

FileUtils.mv("test2.txt", "test5.txt")
FileUtils.mv("test5.txt", "test2.txt")


# dir ops

p Dir.pwd

# Dir.chdir()

dir = Dir.open(".")
while name = dir.read
  p name
end
dir.close

p Dir.glob("*.txt")


# Dir.mkdir
# Dir.rmdir


st = File.stat("test2.txt")
p st
p st.ctime
p st.mtime
p st.atime

# File.chmod(0755, "test.txt")


# ======================
# filetest


p FileTest.exists?("a.txt")
p FileTest.file?("test2.txt")


# path
p File.basename("/user/local/bin/ruby")
p File.dirname("/user/local/bin/ruby")
p File.extname("a.rb")
p File.split("/user/local/bin/ruby")
p File.join("/usr/bin", "ruby")
p File.expand_path("~")

# =====================

# other
# Find
# tempfile
# fileutils

