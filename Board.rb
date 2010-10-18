require 'GUI'
require 'set'

class Board

	attr_accessor :grid

  @@colors = [0,1,2,3,4,5]
  @@done_boards = {:zero => 72734037, :one => 83853311, :two => 83918849,:three => 95038123, :four => 117407741, :five => 106288471}

    def initialize
		
    width,height = 12,12
    num_colors = 6
   
    @grid = Array.new(width)
		@grid.map! do |x| Array.new(height,0) end
		@grid.map! do |one| one.map! do |each| rand(num_colors) end end

  end

  def self.colors 
    @@colors
  end

	def flip!(target_color)
    source_color = @grid[0][0]

    if source_color == target_color
      return nil
    else
      return self.flip_at(0,0,source_color,target_color)
    end
    
    return self.flip_at(0,0,source_color,target_color)
  end

  def flip(target_color)
    temp_board = self.clone
    source_color = temp_board.grid[0][0]
    if source_color == target_color
      return nil
    else
      return temp_board.flip_at(0,0,source_color,target_color)
    end
    
   end

  def flip_at(x,y,src_c,tar_c)
      neighbors = get_neighbors(x,y)
      @grid[x][y] = tar_c
      
      neighbors.each do |side|
        x_t,y_t = side
        self.flip_at(x_t,y_t,src_c,tar_c) if @grid[x_t][y_t] == src_c
      end
      return self
  end

  def inside(x,y)
    (x >= 0 and x < @grid.size) && (y >= 0 && y < @grid.size)
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
    temp.grid = @grid.clone
    temp.grid.each_with_index do |arr, i| temp.grid[i] = arr.clone end 
  end

  def hash
    @grid.hash
  end

  ### PRINTER METHODS ###
  
  def display
		@grid.each do |r|
			r.each do |c|
				print "#{c} "	
			end
			puts "\n"
		end
	end

  def done?
    @@done_boards.has_value? self.hash
  end

### HELPER METHODS ###

  def self.puts_obj(o)
    puts "%s ==> %X" % [o.class, o.object_id]
  end

  def print_objects(board)
    Board.puts_obj(board)
    board.map do |x| Board.puts_obj(x) end
    puts "\n"
  end


end

