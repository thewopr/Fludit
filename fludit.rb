require 'GUI'
require 'Board'

b = Board.new(12,12,6)
b.display

g = GUI.new(b)

thread = Thread.new() do g.start end

#Interactive Shell

while(true) do
  command = gets.chomp
  begin
    eval command
  rescue Exception => msg
    puts msg
  end
  g.redraw_board
end