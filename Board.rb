require 'GUI'
require 'set'

class Board < Array

	attr_accessor :colors, :blob 

	def initialize(width,height,num_colors)
		super(width)
		map! do |x| Array.new(height,0) end

		@colors = 0...num_colors;
		@colors = @colors.to_a
		
		map! do |one| one.map! do |each| rand(num_colors) end end
	end

	def display
	
		self.each do |r|
			r.each do |c|
				print "#{c} "	
			end
			puts "\n"
		end

	end

	def to_s
		"Board ==== "  + inspect
	end

  def flip!(target_color)
    source_color = self[0][0]
    puts "Flipping all the #{source_color} ==> #{target_color}"
    return flip_at(self,0,0,source_color,target_color)
  end


  def flip(target_color)
    temp_board = self.clone
    source_color = self[0][0]
    puts "Flipping all the #{source_color} ==> #{target_color}"
    return flip_at(temp_board,0,0,source_color,target_color)
  end

  def flip_at(board,x,y,src_c,tar_c)
      
      neighbors = get_neighbors(x,y)
      board[x][y] = tar_c
      
      neighbors.each do |side|
        x_t,y_t = side
        flip_at(board,x_t,y_t,src_c,tar_c) if board[x_t][y_t] == src_c
      end
      return board
  end

  def inside(x,y)
    (x >= 0 and x < self.size) && (y >= 0 && y< self.size)
  end

  def get_neighbors(x,y)
      n = []
      n << [x+1,y  ] if inside(x+1,y)
      n << [x  ,y-1] if inside(x,y-1)
      n << [x-1,y  ] if inside(x-1,y)
      n << [x  ,y+1] if inside(x,y+1)

     return n 
  end

end

b = Board.new(12,12,6)
b.display

g = GUI.new(b)

thread = Thread.new() do g.start end

while(true) do
  command = gets.chomp
  begin
    eval command
  rescue Exception => msg
    puts msg
  end
  g.redraw_board
end
