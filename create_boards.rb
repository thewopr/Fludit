require 'Board'

path = "b%d.obj"
num = 100

num.times do |i|
  fOut = File.new(path % i, "w")
  Marshal.dump(Board.new,fOut)
end
