require 'Board'

files = "boards/b%d.obj"

results = File.new("results/random_AI.txt", "w")
results_arr = Array.new

100.times do |i|

  board = Marshal.load( File.open(files % i) )
  
  turn = 0

  while !board.done?
    x = board.flip!(rand(Board.colors.size))
    if x != nil 
      turn += 1
    end

  end

  results.print "%s\n" % turn
  results_arr << turn

end
ave = results_arr.inject(0) do |sum,ele| sum+ele end / 100.0
 
puts "Average of 100 games == %d" % ave
puts "Best Game == %d" % results_arr.min
puts "Worst Game == %d" % results_arr.max

