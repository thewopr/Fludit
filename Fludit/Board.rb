class Board

	attr_accessor :grid, :colors

	def initialize(width,height,num_colors)
		@grid = Array.new(width, Array.new(height))
		@colors = 0...num_colors;
		@colors = @colors.to_a
		
		@grid.each_with_index do |each, r|
			each.each_with_index do |each2, c|
				@grid[r][c] = rand(num_colors)
			end
		end		
	end

	def print
	
		@grid.each do |r|
			r.each do |c|
				print "#{c}"
			end
			print "\n"
		end

	end

	def to_s
		"Board ==== "  + @grid.inspect
	end
	
end

b = Board.new(12,12,6)
b.print
