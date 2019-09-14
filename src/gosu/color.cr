module Gosu
  @[Link("gosu")]
  lib ColorC
    fun create_color = Gosu_Color_create(color : UInt32) : UInt32
    fun create_color_argb = Gosu_Color_create_argb(alpha : UInt8, red : UInt8, green : UInt8, blue : UInt8) : UInt32
    fun create_color_from_hsv = Gosu_Color_create_from_hsv(hue : Float64, saturation : Float64, value : Float64) : UInt32
    fun create_color_from_ahsv = Gosu_Color_create_from_ahsv(alpha : UInt8, hue : Float64, saturation : Float64, value : Float64) : UInt32
    fun color_gl = Gosu_Color_gl(color : UInt32) : UInt32
  end

  class Color
    def self.argb(color : UInt32|Int64) : Gosu::Color
      return Gosu::Color.new(color)
    end

    def self.argb(alpha : UInt8|Int64, red : UInt8|Int64, green : UInt8|Int64, blue : UInt8|Int64) : Gosu::Color
      return Gosu::Color.new(alpha.to_u8, red.to_u8, green.to_u8, blue.to_u8)
    end

    def self.rgba(red : UInt8|Int64, green : UInt8|Int64, blue : UInt8|Int64, alpha : UInt8|Int64) : Gosu::Color
      Gosu::Color.argb(alpha.to_u8, red.to_u8, green.to_u8, blue.to_u8)
    end

    def self.rgb(red : UInt8|Int64, green : UInt8|Int64, blue : UInt8|Int64) : Gosu::Color
      Gosu::Color.argb(255.to_u8, red.to_u8, green.to_u8, blue.to_u8)
    end

    def self.hsv(hue : Float64, saturation : Float64, value : Float64) : Gosu::Color
      Gosu::Color.new(ColorC.create_color_from_hsv(hue, saturation, value))
    end

    def self.ahsv(alpha : UInt8, hue : Float64, saturation : Float64, value : Float64) : Gosu::Color
      Gosu::Color.new(ColorC.create_color_from_ahsv(alpha.to_u8, hue, saturation, value))
    end

    def initialize(color : UInt32|Int64)
      @color = ColorC.create_color(color)
    end

    def initialize(alpha : UInt8, red : UInt8, green : UInt8, blue : UInt8)
      @color = ColorC.create_color_argb(alpha, red, green, blue)
    end

    def gl : UInt32
      ColorC.color_gl(@color)
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
