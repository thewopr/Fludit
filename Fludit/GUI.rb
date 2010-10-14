require 'gtk2'

class GUI 

	def initialize(grid, colors)
    @grid = grid
    @colors = [
              Gdk::Color.new(0,0,0),
              Gdk::Color.new(255,255,255),
              Gdk::Color.new(255,0,0),
              Gdk::Color.new(0,255,0),
              Gdk::Color.new(0,0,255),
              Gdk::Color.new(125,125,125)]
  
  end

  def display
    Gtk.init
    @gw = Gtk::Window.new("Fludit!")
    @gw.resize(400,400)
    
    @gw.show
    
    @gw.signal_connect('delete_event') { Gtk.main_quit }

    @area = Gtk::DrawingArea.new
    @area.set_size_request(240,240)

    @gw.add(@area)
    @gw.showall
  
    update

    Gtk.main
  end
    
  def update
  
    @grid.each_with_index do |r, x|
      r.each_with_index do |c, y|
        @area.style = @colors[c]
        @area.window.draw_rectangle(@gc,true,x,y,20,20)
      end
    end

    #@gw.draw_drawable(@gc, @buffer,0,0,0,0,-1,-1)
  end
end
