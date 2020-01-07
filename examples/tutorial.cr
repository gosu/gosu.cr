require "../src/gosu"

GAME_PATH = File.expand_path("..", __FILE__)

module ZOrder
  BACKGROUND = 0
  STARS = 1
  PLAYER = 2
  UI = 3
end

class Player
  getter :score

  def initialize
    @image = Gosu::Image.new("#{GAME_PATH}/media/starfighter.bmp")
    @beep = Gosu::Sample.new("#{GAME_PATH}/media/beep.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.5)
    @vel_y += Gosu.offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 35
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end
end

class Star
  @x : Float64
  @y : Float64
  @animation : Array(Gosu::Image)
  @color : Gosu::Color
  getter :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * 640
    @y = rand * 480
  end

  def draw
    img = @animation[Gosu.milliseconds // 100 % @animation.size]
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::STARS, 1, 1, @color, :add)
  end
end

class Tutorial < Gosu::Window
  def initialize
    @background_image = Gosu::Image.new("#{GAME_PATH}/media/space.png", tileable: true)

    @player = Player.new
    @player.warp(320.0, 240.0)

    @star_anim = Gosu::Image.load_tiles("#{GAME_PATH}/media/star.png", 25, 25)
    @stars = [] of Star

    @font = Gosu::Font.new(20)

    super 640, 480
    self.caption = "Tutorial Game"
  end

  def update
    if Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::GP_LEFT)
      @player.turn_left
    end
    if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::GP_RIGHT)
      @player.turn_right
    end
    if Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::GP_BUTTON_0)
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 && @stars.size < 25
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw_text("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Tutorial.new.show