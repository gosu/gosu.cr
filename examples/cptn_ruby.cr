# A simple jump-and-run/platformer game with a tile-based map.

# Shows how to
#  * implement jumping/gravity
#  * implement scrolling using Window#translate
#  * implement a simple tile-based map
#  * load levels from primitive text files

# Some exercises, starting at the real basics:
#  0) understand the existing code!
# As shown in the tutorial:
#  1) change it use Gosu's Z-ordering
#  2) add gamepad support
#  3) add a score as in the tutorial game
#  4) similarly, add sound effects for various events
# Exploring this game's code and Gosu:
#  5) make the player wider, so he doesn't fall off edges as easily
#  6) add background music (check if playing in Window#update to implement
#     looping)
#  7) implement parallax scrolling for the star background!
# Getting tricky:
#  8) optimize Map#draw so only tiles on screen are drawn (needs modulo, a pen
#     and paper to figure out)
#  9) add loading of next level when all gems are collected
# ...Enemies, a more sophisticated object system, weapons, title and credits
# screens...

require "../src/gosu"

WIDTH = 640
HEIGHT= 480

GAME_PATH = File.expand_path("..", __FILE__)

module Tiles
  Grass = 0
  Earth = 1
end

class CollectibleGem
  getter :x, :y
  @x : Int32
  @y : Int32
  @image : Gosu::Image

  def initialize(image, x, y)
    @image = image
    @x, @y = x, y
  end

  def draw
    # Draw, slowly rotating
    @image.draw_rot(@x, @y, 0, 25 * Math.sin(Gosu.milliseconds / 133.7))
  end
end

# Player class.
class Player
  getter :x, :y
  @standing : Gosu::Image
  @walk1 : Gosu::Image
  @walk2 : Gosu::Image
  @jump : Gosu::Image

  @map : Map

  @x : Int32
  @y : Int32

  def initialize(map, x, y)
    @x, @y = x, y
    @dir = :left
    @vy = 0 # Vertical velocity
    @map = map
    # Load all animation frames
    captn = Gosu::Image.load_tiles("#{GAME_PATH}/media/cptn_ruby.png", 50, 50)
    @standing, @walk1, @walk2, @jump = captn[0], captn[1], captn[2], captn[3]
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    @cur_image = @standing
  end

  def draw
    # Flip vertically when facing to the left.
    if @dir == :left
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end

  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    !@map.solid?(@x + offs_x, @y + offs_y) &&
      !@map.solid?(@x + offs_x, @y + offs_y - 45)
  end

  def update(move_x)
    # Select image depending on action
    if (move_x == 0)
      @cur_image = @standing
    else
      @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @jump
    end

    # Directional walking, horizontal movement
    if move_x > 0
      @dir = :right
      move_x.times { if would_fit(1, 0); @x += 1; end }
    end
    if move_x < 0
      @dir = :left
      (-move_x).times { if would_fit(-1, 0); @x -= 1; end }
    end

    # Acceleration/gravity
    # By adding 1 each frame, and (ideally) adding vy to y, the player's
    # jumping curve will be the parabole we want it to be.
    @vy += 1
    # Vertical movement
    if @vy > 0
      @vy.times { if would_fit(0, 1); @y += 1 else @vy = 0; end }
    end
    if @vy < 0
      (-@vy).times { if would_fit(0, -1); @y -= 1 else @vy = 0; end }
    end
  end

  def try_to_jump
    if @map.solid?(@x, @y + 1)
      @vy = -20
    end
  end

  def collect_gems(gems)
    # Same as in the tutorial game.
    gems.reject! do |c|
      (c.x - @x).abs < 50 && (c.y - @y).abs < 50
    end
  end
end

# Map class holds and draws tiles and gems.
class Map
  getter :width, :height, :gems
  @width : Int32
  @height : Int32

  def initialize(filename)
    # Load 60x60 tiles, 5px overlap in all four directions.
    @tileset = [] of Gosu::Image
    @tileset = Gosu::Image.load_tiles("#{GAME_PATH}/media/tileset.png", 60, 60, tileable: true)

    gem_img = Gosu::Image.new("#{GAME_PATH}/media/gem.png")
    @gems = [] of CollectibleGem

    lines = File.read(filename).lines.map { |line| line.chomp }
    @height = lines.size
    @width = lines[0].size
    @tiles = [] of Array(Int32?)

    @width.times do |x|
      @tiles << [] of Int32?
      @height.times do |y|
        item = nil
        case lines[y][x, 1]
        when "\""
          item = Tiles::Grass
        when "#"
          item = Tiles::Earth
        when "x"
          @gems.push(CollectibleGem.new(gem_img, x * 50 + 25, y * 50 + 25))
          nil
        else
          nil
        end

        @tiles[x] << item
      end
    end
  end

  def draw
    # Very primitive drawing function:
    # Draws all the tiles, some off-screen, some on-screen.
    @height.times do |y|
      @width.times do |x|
        tile = @tiles.dig?(x, y)
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
        end
      end
    end
    @gems.each { |c| c.draw }
  end

  # Solid at a given pixel position?
  def solid?(x, y)
    y < 0 || @tiles.dig?((x / 50).to_i, (y / 50).to_i)
  end
end

class CptnRuby < Gosu::Window
  @camera_x : Float64
  @camera_y : Float64

  def initialize
    super WIDTH, HEIGHT

    @sky = Gosu::Image.new("#{GAME_PATH}/media/space.png", tileable: true)
    @map = Map.new("#{GAME_PATH}/media/cptn_ruby_map.txt")
    @cptn = Player.new(@map, 400, 100)
    # The scrolling position is stored as top left corner of the screen.
    @camera_x = 0
    @camera_y = 0

    self.caption = "Cptn. Ruby"
  end

  def update
    move_x = 0
    move_x -= 5 if Gosu.button_down?(Gosu::KB_LEFT)
    move_x += 5 if Gosu.button_down?(Gosu::KB_RIGHT)
    @cptn.update(move_x)
    @cptn.collect_gems(@map.gems)
    # Scrolling follows player
    @camera_x = [[@cptn.x - WIDTH / 2, 0].max, @map.width * 50 - WIDTH].min.to_f64
    @camera_y = [[@cptn.y - HEIGHT / 2, 0].max, @map.height * 50 - HEIGHT].min.to_f64
  end

  def draw
    @sky.draw 0, 0, 0
    Gosu.translate(-@camera_x, -@camera_y) do
      @map.draw
      @cptn.draw
    end
  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      @cptn.try_to_jump
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

CptnRuby.new.show