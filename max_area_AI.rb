###############
# Just what it looks like. This AI's strategy is to randomly pick a color
# at every step
#
###############
require 'Board'

files = "boards/b%d.obj"

results = File.new("results/random_AI.txt", "w")
results_arr = Array.new

100.times do |i|

  board = Marshal.load( File.open(files % i) )
  
  turn = 0

  while !board.done? || turn == 5

    max_gain = Array.new

    Board.colors.each do |col| 
      poss_outcome = board.flip(col)
      if poss_outcome.nil?
        max_gain << 0
      else
        max_gain << poss_outcome.count_blob(0,0)
      end
    end
    
    board.flip!( max_gain.index(max_gain.max ))

    turn += 1
  end

  results.print "%s\n" % turn
  results_arr << turn

end
ave = results_arr.inject(0) do |sum,ele| sum+ele end / 100.0
 
puts "Average of 100 games == %d" % ave
puts "Best Game == %d" % results_arr.min
puts "Worst Game == %d" % results_arr.max

