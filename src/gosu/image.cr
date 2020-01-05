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
    fun load_tiles = Gosu_Image_create_from_tiles(filename : UInt8*, width : Int32, height : Int32,
                                                  function : (Void*, UInt8* ->), data : Void*, image_flags : UInt32)
    fun load_tiles_from_image = Gosu_Image_create_tiles_from_image(image : UInt8*, width : Int32, height : Int32,
                                                                   function : (Void*, UInt8* ->), data : Void*, image_flags : UInt32)
    fun subimage = Gosu_Image_create_from_subimage(image : UInt8*, left : Int32, top : Int32, width : Int32, height : Int32) : UInt8*

    fun draw = Gosu_Image_draw(image : UInt8*, x : Float64, y : Float64, z : Float64,
                                     scale_x : Float64, scale_y : Float64, color : UInt32, flags : UInt32)
    fun draw_rot = Gosu_Image_draw_rot(image : UInt8*, x : Float64, y : Float64, z : Float64, angle : Float64,
                                       center_x : Float64, center_y : Float64, scale_x : Float64, scale_y : Float64,
                                       color : UInt32, flags : UInt32)
    fun draw_as_quad = Gosu_Image_draw_as_quad(image : UInt8*, x1 : Float64, y1 : Float64, c1 : UInt32,
                                               x2 : Float64, y2 : Float64, c2 : UInt32,
                                               x3 : Float64, y3 : Float64, c3 : UInt32,
                                               x4 : Float64, y4 : Float64, c4 : UInt32,
                                               z : Float64, color : UInt32, flags : UInt32)

    fun width = Gosu_Image_width(image : UInt8*) : Int32
    fun height = Gosu_Image_height(image : UInt8*) : Int32

    fun to_blob = Gosu_Image_to_blob(image : UInt8*) : UInt8*
    fun save = Gosu_Image_save(image : UInt8*, filename : UInt8*)
    fun insert = Gosu_Image_insert(image : UInt8*, other : UInt8*, x : Int32, y : Int32)

    fun destroy_image = Gosu_Image_destroy(image : UInt8*)
  end

  class Image
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

    def self.load_tiles(filename_or_image : String | Gosu::Image, width : Int32, height : Int32,
                        retro : Bool = false, tileable : Bool = false) : Array(Gosu::Image)
      raise "Can not open file: #{filename_or_image}" if filename_or_image.is_a?(String) && !File.exists?(filename_or_image)
      tiles = [] of Gosu::Image

      proc = ->(image : UInt8*) { tiles << Gosu::Image.new(image) }
      box = Box.box(proc)

      if filename_or_image.is_a?(String)
        ImageC.load_tiles(filename_or_image, width, height, ->(data : Void*, image : Pointer(UInt8)) {
          callback = Box(typeof(proc)).unbox(data)
          callback.call(image)
        }, box, Gosu.image_flags(retro, tileable))

      else
        ImageC.load_tiles_from_image(filename_or_image.pointer, width, height, ->(data : Void*, image : UInt8*) {
          callback = Box(typeof(proc)).unbox(data)
          callback.call(image)
        }, box, Gosu.image_flags(retro, tileable))
      end

      return tiles
    end

    def initialize(filename : String, retro : Bool = false, tileable : Bool = false)
      raise "Can not open file: #{filename}" unless File.exists?(filename)
      @__image = ImageC.create_image(filename, Gosu.image_flags(retro, tileable))
    end

    def initialize(pointer : UInt8*)
      @__image = pointer
    end

    # :nodoc:
    def pointer
      @__image
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
      ImageC.draw(pointer, x.to_i, y.to_i, z.to_i, scale_x.to_i, scale_y.to_i, color, Gosu.blend_mode(mode))
    end

    def draw_rot(x : Float64 | Int32, y : Float64 | Int32, z : Float64 | Int32,
                 angle : Float64 | Int32, center_x : Float64 | Int32 = 0.5, center_y : Float64 | Int32 = 0.5,
                 scale_x : Float64 | Int32 = 1, scale_y : Float64 | Int32 = 1, color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE,
                 mode : Symbol = :default)
      ImageC.draw_rot(pointer, x, y, z, angle, center_x, center_y, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    def draw_as_quad(x1 : Float64 | Int32, y1 : Float64 | Int32, c1 : Gosu::Color | Int64 | UInt32,
                     x2 : Float64 | Int32, y2 : Float64 | Int32, c2 : Gosu::Color | Int64 | UInt32,
                     x3 : Float64 | Int32, y3 : Float64 | Int32, c3 : Gosu::Color | Int64 | UInt32,
                     x4 : Float64 | Int32, y4 : Float64 | Int32, c4 : Gosu::Color | Int64 | UInt32,
                     z : Float64 | Int32, mode : Symbol)
      ImageC.draw_as_quad(x1.to_f64, y1.to_f64, Gosu.color_to_drawop(c1),
                          x2.to_f64, y2.to_f64, Gosu.color_to_drawop(c2),
                          x3.to_f64, y3.to_f64, Gosu.color_to_drawop(c3),
                          x4.to_f64, y4.to_f64, Gosu.color_to_drawop(c4),
                          z.to_f64, Gosu.blend_mode(mode))
    end

    def width
      ImageC.width(pointer)
    end

    def height
      ImageC.height(pointer)
    end

    def to_blob
      String.new(ImageC.to_blob(pointer), width * height * 4)
    end

    def save(filename : String)
      ImageC.save(pointer, filename)
    end

    def insert(other : Gosu::Image, x : Int32, y : Int32)
      ImageC.insert(pointer, other.pointer, x, y)
    end

    def subimage(left : Int32, top : Int32, width : Int32, height : Int32) : Gosu::Image
      Gosu::Image.new( ImageC.subimage(pointer, left, top, width, height) )
    end

    # :nodoc:
    def finalize
      ImageC.destroy_image(pointer)
    end
  end
end
