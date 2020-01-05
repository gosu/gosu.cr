module Gosu
  @[Link("gosu")]
  lib ImageC
    fun create_image = Gosu_Image_create(filename : UInt8*, flags : UInt32) : UInt8*
    fun create_image_from_text = Gosu_Image_create_from_text(text : UInt8*, font : UInt8*, line_height : Float64,
                                                             width : Int32, spacing : Float64, alignment_flags : UInt32,
                                                             font_flags : UInt32, image_flags : UInt32) : UInt8*
    fun create_image_from_markup = Gosu_Image_create_from_markup(text : UInt8*, font : UInt8*, line_height : Float64,
                                                                 width : Int32, spacing : Float64, alignment_flags : UInt32,
                                                                 font_flags : UInt32, image_flags : UInt32) : UInt8*

    fun image_draw = Gosu_Image_draw(image : UInt8*, x : Float64, y : Float64, z : Float64,
                                     scale_x : Float64, scale_y : Float64, color : UInt32, flags : UInt32)

    fun image_width = Gosu_Image_width(image : UInt8*) : Int32
    fun image_height = Gosu_Image_height(image : UInt8*) : Int32

    fun image_to_blob = Gosu_Image_to_blob(image : UInt8*) : UInt8*
    fun image_save = Gosu_Image_save(image : UInt8*, filename : UInt8*)

    fun destroy_image = Gosu_Image_destroy(image : UInt8*)
  end

  class Image
    # Converts flags to `UInt32` bitmask.
    def self.image_flags(retro : Bool = false) : UInt32
      mask : UInt32 = 0

      mask |= 1 << 5 if retro

      return mask
    end

    def self.from_text(text : String, line_height : Float64, font : String = Gosu.default_font_name, width : Float64 = -1,
                       spacing : Float64 = 0, align : Symbol = :left, bold : Bool = false, italic : Bool = false, underline : Bool = false,
                       retro : Bool = false) : Gosu::Image
      Gosu::Image.new( ImageC.create_image_from_text(text, font, line_height, width, spacing, Gosu.font_alignment_flags(align),
                                                     Gosu.font_flags(bold, italic, underline), Gosu.image_flags(retro)) )
    end

    def self.from_markup(markup : String, line_height : Float64, font : String = Gosu.default_font_name, width : Float64 = -1,
                       spacing : Float64 = 0, align : Symbol = :left, bold : Bool = false, italic : Bool = false, underline : Bool = false,
                       retro : Bool = false) : Gosu::Image
      Gosu::Image.new( ImageC.create_image_from_markup(markup, font, line_height, width, spacing, Gosu.font_alignment_flags(align),
                                                       Gosu.font_flags(bold, italic, underline), Gosu.image_flags(retro)) )
    end

    def initialize(filename : String, retro : Bool = false)
      @__image = ImageC.create_image(filename, Gosu.image_flags(retro))
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
    def draw(x : Float64 | Int32, y : Float64 | Int32, z : Float64 | Int32,
             scale_x : Float64 | Int32 = 1.0, scale_y : Float64 | Int32 = 1.0, color : UInt32 = 0xffffffff,
             mode : Symbol = :default)
      ImageC.image_draw(@__image, x.to_i, y.to_i, z.to_i, scale_x.to_i, scale_y.to_i, color, Gosu.blend_mode(mode))
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

    def save(filename : String)
      ImageC.image_save(@__image, filename)
    end

    # :nodoc:
    def finalize
      ImageC.destroy_image(@__image)
    end
  end
end
