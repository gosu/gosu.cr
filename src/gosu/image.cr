module Gosu
  @[Link("gosu")]
  lib ImageC
    fun create_image = Gosu_Image_create(filename : UInt8*, flags : UInt32) : UInt8*
    fun image_draw = Gosu_Image_draw(image : UInt8*, x : Float64, y : Float64, z : Float64,
                                     scale_x : Float64, scale_y : Float64, color : UInt32, flags : UInt32)
    fun image_width = Gosu_Image_width(image : UInt8*) : Int32
    fun image_height = Gosu_Image_height(image : UInt8*) : Int32
    fun image_to_blob = Gosu_Image_to_blob(image : UInt8*) : UInt8*
    fun destroy_image = Gosu_Image_destroy(image : UInt8*)
  end

  class Image
    # Converts `mode` to number.
    # Valid  blend modes are: `:default` and `:additive`.
    def self.blend_mode(mode : Symbol) : Int32
      case mode
      when :default
        0
      when :additive
        1
      else
        0
      end
    end

    # Converts flags to `UInt32` bitmask.
    def self.flags_to_bitmask(retro : Bool = false) : UInt32
      mask : UInt32 = 0

      mask |= 1 << 5 if retro

      return mask
    end

    def initialize(filename : String, retro : Bool = false)
      @__image = ImageC.create_image(filename, Image.flags_to_bitmask(retro))
    end

    def initialize(pointer : UInt8*)
      @__image = pointer
    end

    # Draws the image with its top left corner at (x, y).
    #
    # `x` the X coordinate.
    #
    # `y` the Y coordinate.
    #
    # `z` the Z-order.
    #
    # `scale_x` the horizontal scaling factor.
    #
    # `scale_y` the vertical scaling factor.
    #
    # `color` a `Gosu::Color` or `UInt32`
    #
    # `mode` [:default, :additive] the blending mode to use.
    #
    #
    # See `draw_rot`
    # See `draw_as_quad`
    # See https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    # See https://github.com/gosu/gosu/wiki/Basic-Concepts#z-ordering Z-ordering explained in the Gosu Wiki
    def draw(x : Float64, y : Float64, z : Float64, scale_x : Float64 = 1.0, scale_y : Float64 = 1.0, color : UInt32 = 0xffffffff, mode : Symbol = :default)
      ImageC.image_draw(@__image, x, y, z, scale_x, scale_y, color, Image.blend_mode(mode))
    end

    def width
      ImageC.image_width(@__image)
    end

    def height
      ImageC.image_height(@__image)
    end

    def to_blob
      String.new(ImageC.image_to_blob(@__image), width * height * 4)
    end

    # :nodoc:
    def finalize
      ImageC.destroy_image(@__image)
    end
  end
end
