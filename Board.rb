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

    @blob = Set.new
    @blob.add( [0,0])
    puts @blob

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

  def flip(target_color)

    @flipped = Set.new
   

    source_color = self[0][0]
    puts "Flipping all the #{source_color} ==> #{target_color}"
    flip_at(0,0,source_color,target_color)
    puts @flipped.inspect
    display

  end


  def flip_at(x,y,src_c,tar_c)
      
      neighbors = get_neighbors(x,y)
      self[x][y] = tar_c
      @flipped.add( [x,y] )

      neighbors.each do |side|
        x_t,y_t = side
        flip_at(x_t,y_t,src_c,tar_c) if self[x_t][y_t] == src_c
      end

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
  command =  gets.chomp
  eval(command)
  g.redraw_board
end

Thread.list.each {|t| p t.inspect}

