require 'GUI'
require 'set'

class Board < Array

	attr_accessor :colors 

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

  def flip!(target_color)
    source_color = self[0][0]
    return self.flip_at(0,0,source_color,target_color)
  end

  def self.puts_obj(o)
    puts "%s ==> %X" % [o.class, o.object_id]
  end

  def disp_addrs(board)
    Board.puts_obj(board)
    board.map do |x| Board.puts_obj(x) end
    puts "\n"
  end


  def flip(target_color)
    temp_board = self.clone
    source_color = temp_board[0][0]
    return temp_board.flip_at(0,0,source_color,target_color)
  end

  def flip_at(x,y,src_c,tar_c)
      neighbors = get_neighbors(x,y)
      self[x][y] = tar_c
      
      neighbors.each do |side|
        x_t,y_t = side
        self.flip_at(x_t,y_t,src_c,tar_c) if self[x_t][y_t] == src_c
      end
      return self
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

  def clone
    temp = self.dup
    temp.each_with_index do |arr, i| temp[i] = arr.clone end 
  end

end

