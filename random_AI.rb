require 'Board'

files = "boards/b%d.obj"

4.times do |i|

  board = Marshal.load( File.open(files % i) )
  puts "== Board #{i} =="
  board.display

end
