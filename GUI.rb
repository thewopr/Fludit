require 'gtk2'

class GUI < Gtk::Window 

	def initialize(board)
    @board = board
    @colors = [
              Gdk::Color.parse("Black"),
              Gdk::Color.parse("White"),
              Gdk::Color.parse("Blue"),
              Gdk::Color.parse("Yellow"),
              Gdk::Color.parse("Red"),
              Gdk::Color.parse("Green")]
    @width = @board.grid.size
    @height = @board.grid[0].size

    @rect_size = 60
    
    super("Fludit!")
    resize(@rect_size * @width,@rect_size * @height)    
    signal_connect('delete_event') { Gtk.main_quit }

    @area = Gtk::DrawingArea.new
    @area.set_size_request(@rect_size * @width,@rect_size * @height)
    @area.signal_connect('expose_event')        { |w, e| redraw_board }

    add(@area)
    show_all
    
    @gc = Gdk::GC.new(@area.window)
    @text = self.create_pango_layout("0")
    @text.width = @rect_size
    @text.justify = true
  end 

  def start
    Gtk.main
  end

  def redraw_board
        puts "Redrawing board (%X)" % @board.object_id
        @board.grid.each_with_index do |r, x|
      r.each_with_index do |c, y|
        @text.markup = "<span font_desc=\"30\">\%d</span>" % c
#        @text.set_text(c.to_s)
        @gc.set_rgb_fg_color( @colors[c] )
        @area.window.draw_rectangle(@gc,true,y*@rect_size,x*@rect_size,@rect_size,@rect_size)
        @area.window.draw_layout(@gc,y*@rect_size,x*@rect_size,@text,@colors[0],nil)
      end
    end
  end
end
