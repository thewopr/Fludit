class Board

	attr_accessor :grid, :colors

	def initialize(width,height,num_colors)
		@grid = Array.new(width)
		@grid.map! do |x| Array.new(height,0) end

		@colors = 0...num_colors;
		@colors = @colors.to_a
		
		@grid.map! do |one| one.map! do |each| rand(num_colors) end end
	end

	def display
	
		@grid.each do |r|
			r.each do |c|
				print "%d " % c	
			end
			puts "\n"
		end

	end

	def to_s
		"Board ==== "  + @grid.inspect
	end
	
end

b = Board.new(12,12,6)
b.display
