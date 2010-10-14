require 'gtk2'

class GUI 

	def initialize(grid, colors)
    @grid = grid
    @colors = [
              Gdk::Color.parse("Black"),
              Gdk::Color.parse("White"),
              Gdk::Color.parse("Blue"),
              Gdk::Color.parse("Yellow"),
              Gdk::Color.parse("Red"),
              Gdk::Color.parse("Green")]
    @width = @grid.size
    @height = @grid[0].size

    @rect_size = 60

  end

  def display
    Gtk.init
    @gw = Gtk::Window.new("Fludit!")
    @gw.resize(@rect_size * @width,@rect_size * @height)    
    @gw.signal_connect('delete_event') { Gtk.main_quit }

    @area = Gtk::DrawingArea.new
    @area.set_size_request(@rect_size * @width,@rect_size * @height)
    @area.signal_connect('expose_event')        { |w, e| redraw_board }

    @gw.add(@area)
    @gw.show_all

    @gc = Gdk::GC.new(@area.window)
    @gc.function = Gdk::GC::COPY

    @gc.colormap = Gdk::Colormap.system

    Gtk.main
  end
    
  def redraw_board
    @grid.each_with_index do |r, x|
      r.each_with_index do |c, y|
        @gc.set_foreground( @colors[c] )
        @area.window.draw_rectangle(@gc,true,x*@rect_size,y*@rect_size,@rect_size,@rect_size)
        #puts "Drawing rectangle (#{x},#{y}) ==> #{@colors[c].to_s} ==> #{@gc.foreground}"
      end
    end
  end
end
