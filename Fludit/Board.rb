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

  def flip(color)
    flip_at(0,0,color)
  end


  def flip_at(x,y,color)
      
      s,e = get_s_e(x,y)
      
      flip_at(s[0],s[1],color) unless self[x][y] != self[s[0]][s[1]]
      flip_at(e[0],e[1],color) unless self[x][y] != self[e[0]][e[1]]

      self[x][y] = color

  end

  def get_s_e(x,y)
      [[x+1,y], [x,y+1]]
  end


end

b = Board.new(12,12,6)
b.display
g = GUI.new(b)

while(true) do
  command =  gets.chomp
  eval(command)
end
