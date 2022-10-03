module Gosu
  lib ColorC
    fun create_color = Gosu_Color_create(color : UInt32) : UInt32
    fun create_color_argb = Gosu_Color_create_argb(alpha : UInt8, red : UInt8, green : UInt8, blue : UInt8) : UInt32
    fun create_color_from_hsv = Gosu_Color_create_from_hsv(hue : Float64, saturation : Float64, value : Float64) : UInt32
    fun create_color_from_ahsv = Gosu_Color_create_from_ahsv(alpha : UInt8, hue : Float64, saturation : Float64, value : Float64) : UInt32

    fun alpha = Gosu_Color_alpha(color : UInt32) : UInt8
    fun red = Gosu_Color_red(color : UInt32) : UInt8
    fun green = Gosu_Color_green(color : UInt32) : UInt8
    fun blue = Gosu_Color_blue(color : UInt32) : UInt8
    fun set_alpha = Gosu_Color_set_alpha(color : UInt32, value : UInt8) : UInt32
    fun set_red = Gosu_Color_set_red(color : UInt32, value : UInt8) : UInt32
    fun set_green = Gosu_Color_set_green(color : UInt32, value : UInt8) : UInt32
    fun set_blue = Gosu_Color_set_blue(color : UInt32, value : UInt8) : UInt32

    fun value = Gosu_Color_value(color : UInt32) : Float64
    fun saturation = Gosu_Color_saturation(color : UInt32) : Float64
    fun hue = Gosu_Color_hue(color : UInt32) : Float64
    fun set_value = Gosu_Color(color : UInt32, value : Float64) : UInt32
    fun set_saturation = Gosu_Color(color : UInt32, value : Float64) : UInt32
    fun set_hue = Gosu_Color(color : UInt32, value : Float64) : UInt32

    fun bgr = Gosu_Color_bgr(color : UInt32) : UInt32
    fun abgr = Gosu_Color_abgr(color : UInt32) : UInt32
    fun argb = Gosu_Color_argb(color : UInt32) : UInt32

    fun color_gl = Gosu_Color_gl(color : UInt32) : UInt32
  end

  # Represents an ARGB color value with 8 bits for each channel. Colors can be used interchangeably with integer literals of the form 0xAARRGGBB in all Gosu APIs.
  class Color
    # Converts Int32 to UInt8 safely, by clamping value to range [0; 255] then converting to UInt8.
    def self.safe_to_u8(value : Int32 | UInt8) : UInt8
      value.clamp(0, 255).to_u8
    end

    # Creates color from 0xAARRGGBB integer literal.
    def self.argb(color : UInt32) : Gosu::Color
      return Gosu::Color.new(color)
    end

    def self.argb(alpha : UInt8 | Int32, red : UInt8 | Int32, green : UInt8 | Int32, blue : UInt8 | Int32) : Gosu::Color
      return Gosu::Color.new(safe_to_u8(alpha), safe_to_u8(red), safe_to_u8(green), safe_to_u8(blue))
    end

    def self.rgba(red : UInt8 | Int32, green : UInt8 | Int32, blue : UInt8 | Int32, alpha : UInt8 | Int32) : Gosu::Color
      Gosu::Color.argb(safe_to_u8(alpha), safe_to_u8(red), safe_to_u8(green), safe_to_u8(blue))
    end

    def self.rgb(red : UInt8 | Int32, green : UInt8 | Int32, blue : UInt8 | Int32) : Gosu::Color
      Gosu::Color.argb(safe_to_u8(255), safe_to_u8(red), safe_to_u8(green), safe_to_u8(blue))
    end

    # Converts an HSV triplet to an opaque color.
    def self.from_hsv(hue : Float64, saturation : Float64, value : Float64) : Gosu::Color
      Gosu::Color.new(ColorC.create_color_from_hsv(hue % 360.0, saturation.clamp(0.0, 1.0), value.clamp(0.0, 1.0)))
    end

    # Converts an HSV triplet to a color with the alpha channel set to a given value.
    def self.from_ahsv(alpha : UInt8 | Int32, hue : Float64, saturation : Float64, value : Float64) : Gosu::Color
      Gosu::Color.new(ColorC.create_color_from_ahsv(safe_to_u8(alpha), hue % 360.0, saturation.clamp(0.0, 1.0), value.clamp(0.0, 1.0)))
    end

    # Creates color from 0xAARRGGBB integer literal.
    def initialize(color : UInt32)
      @color = ColorC.create_color(color)
    end

    # Creates color from four unsigned 8-bit integers.
    def initialize(alpha : UInt8 | Int32, red : UInt8 | Int32, green : UInt8 | Int32, blue : UInt8 | Int32)
      @color = ColorC.create_color_argb(Color.safe_to_u8(alpha), Color.safe_to_u8(red), Color.safe_to_u8(green), Color.safe_to_u8(blue))
    end

    # Returns the color's alpha channel.
    def alpha : UInt8
      ColorC.alpha(@color)
    end

    # Set the color's alpha channel.
    def alpha=(value : UInt8 | Int32) : UInt32
      @color = ColorC.set_alpha(@color, Color.safe_to_u8(value))
    end

    # Returns the color's red channel.
    def red : UInt8
      ColorC.red(@color)
    end

    # Sets the color's red channel.
    def red=(value : UInt8 | Int32) : UInt32
      @color = ColorC.set_red(@color, Color.safe_to_u8(value))
    end

    # Returns the color's green channel.
    def green : UInt8
      ColorC.green(@color)
    end

    # Sets the color's green channel.
    def green=(value : UInt8 | Int32) : UInt32
      @color = ColorC.set_green(@color, Color.safe_to_u8(value))
    end

    # Returns the color's blue channel.
    def blue : UInt8
      ColorC.blue(@color)
    end

    # Sets the color's green channel.
    def blue=(value : UInt8 | Int32) : UInt32
      @color = ColorC.set_blue(@color, Color.safe_to_u8(value))
    end

    # Returns the color's hue.
    def hue : Float64
      ColorC.hue(@color)
    end

    # Sets the color's hue.
    def hue=(value : Float64 | Int32) : UInt32
      @color = ColorC.set_hue(value.to_f64 % 360.0)
    end

    # Returns the color's saturation.
    def saturation : Float64
      ColorC.saturation(@color)
    end

    # Sets the color's saturation.
    def saturation=(value : Float64 | Int32) : UInt32
      @color = ColorC.set_saturation(value.to_f64.clamp(0.0, 1.0))
    end

    # Returns the color's value (lightness).
    def value : Float64
      ColorC.value(@color)
    end

    # Sets the color's value.
    def value=(value : Float64 | Int32) : UInt32
      @color = ColorC.set_value(value.to_f64.clamp(0.0, 1.0))
    end

    # Returns a 32-bit representation of the color suitable for use with OpenGL calls. This color is stored in a fixed order in memory and its integer value may vary depending on your system's byte order.
    def gl : UInt32
      ColorC.color_gl(@color)
    end

    def hash
      gl
    end

    def eql?(other) : Bool
      self == other
    end

    def ==(other : Gosu::Color) : Bool
      self.gl == other.gl
    end

    NONE    = Gosu::Color.argb(0x00_000000)
    BLACK   = Gosu::Color.argb(0xff_000000)
    GRAY    = Gosu::Color.argb(0xff_808080)
    WHITE   = Gosu::Color.argb(0xff_ffffff)
    AQUA    = Gosu::Color.argb(0xff_00ffff)
    RED     = Gosu::Color.argb(0xff_ff0000)
    GREEN   = Gosu::Color.argb(0xff_00ff00)
    BLUE    = Gosu::Color.argb(0xff_0000ff)
    YELLOW  = Gosu::Color.argb(0xff_ffff00)
    FUCHSIA = Gosu::Color.argb(0xff_ff00ff)
    CYAN    = Gosu::Color.argb(0xff_00ffff)
  end
end
