require "./src/gosu"


# window = Gosu::Window._create_window(540, 540, false, 16.6, true)
# Gosu::Window._window_set_caption(window, "Hello From Crystal #{Crystal::VERSION}")
# Gosu::Window._window_show(window)
# Gosu::Window._destroy_window(window)

class Window < Gosu::Window
  # @image : Gosu::Image
  def initialize
    # @image = Gosu::Image.new("/home/cyberarm/untitled.png")
    @song = Gosu::Song.new("/home/cyberarm/Downloads/466795__breviceps__bumblebee.wav")
    @song.play(true)

    super(512, 480, false, 16.67, true)
    self.caption = "Hello World"
  end

  def draw
    # @image.draw(0, 0, 0)
  end

  def update
    self.caption = "Hello World: #{Gosu.fps} fps"
    song = Gosu::Song.current_song
    if song
      if song.paused?
        song.play(true)
      else
        song.pause
      end
    end
  end
end

Window.new.show