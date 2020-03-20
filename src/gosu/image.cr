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
    fun create_image_from_blob = Gosu_Image_create_from_blob(blob : UInt8*, size : UInt32, width : Int32, height : Int32,
                                                             image_flags : UInt32) : UInt8*
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

    fun gl_tex_info_create = Gosu_Image_gl_tex_info_create(UInt8*) : Pointer(GLTexInfo)
    fun gl_tex_info_destroy = Gosu_Image_gl_tex_info_destroy(Pointer(GLTexInfo))

    struct GLTexInfo
      tex_name : Int32
      left, right, top, bottom : Float64
    end
  end

  class Image
    # Creates a reusable image from one or more lines of text.
    #
    # NOTE: The text is always rendered in white. To draw it in a different color, use the color parameter of {#draw}, et al.
    #
    # `line_height` the line height, in pixels.
    #
    # `font` the name of a system font, or a path to a TrueType Font (TTF) file. A path must contain at least one '/' character to distinguish it from a system font.
    #
    # `width` the width of the image, in pixels. Long lines will be automatically wrapped around to avoid overflow, but overlong words will be truncated. If this option is omitted, lines will not be wrapped, and :align and :spacing will be ignored as well.
    #
    # `spacing` the spacing between lines, in pixels.
    #
    # `:align` the text alignment, [left, :right, :center, :justify].
    #
    # `retro` if true, the image will not be interpolated when it is scaled up or down.
    #
    # SEE: `Gosu::Font`
    #
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    def self.from_text(text : String, line_height : Float64 | Int32, font : String = Gosu.default_font_name, width : Float64 | Int32 = -1,
                       spacing : Float64 | Int32 = 0, align : Symbol = :left, bold : Bool = false, italic : Bool = false, underline : Bool = false,
                       retro : Bool = false) : Gosu::Image
      Gosu::Image.new(ImageC.create_image_from_text(text, font, line_height, width, spacing, Gosu.font_alignment_flags(align),
        Gosu.font_flags(bold, italic, underline), Gosu.image_flags(retro)))
    end

    # Like `#from_text`, but supports the following markup tags: <b>**bold**</b>, <i>*italic*</i>, and <c=rrggbb>colors</c>.
    def self.from_markup(markup : String, line_height : Float64 | Int32, font : String = Gosu.default_font_name, width : Float64 | Int32 = -1,
                         spacing : Float64 | Int32 = 0, align : Symbol = :left, bold : Bool = false, italic : Bool = false, underline : Bool = false,
                         retro : Bool = false) : Gosu::Image
      Gosu::Image.new(ImageC.create_image_from_markup(markup, font, line_height, width, spacing, Gosu.font_alignment_flags(align),
        Gosu.font_flags(bold, italic, underline), Gosu.image_flags(retro)))
    end

    # Loads an image from a file or an RMagick image, then divides the image into an array of equal-sized tiles.
    #
    # NOTE: For Windows Bitmap (BMP) images, magenta (FF00FF, often called "magic pink" in this context) is treated as a chroma key and all pixels of that color are automatically rendered fully transparent.
    #
    # `tile_width` If positive, this is the width of the individual tiles; if negative, the image is divided into -tile_width columns.
    #
    # `tile_height` If positive, this is the height of the individual tiles; if negative, the image is divided into -tile_height rows.
    #
    #  `retro` if true, the image will not be interpolated when it is scaled up or down. When :retro it set, :tileable has no effect.
    #
    #  `tileable` if true, the Image will not have soft edges when scaled
    #
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#tileability Tileability explained in the Gosu Wiki
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

    # Creates a new image with the given dimensions and RGBA pixel data.
    #
    # `width` Width of the image in pixels.
    #
    # `height` Height of the image in pixels.
    #
    # `rgba` A string containing raw binary image data, with one byte ('uint8') per RGBA component.
    def self.from_blob(width : Int32, height : Int32, rgba : Bytes = Bytes.new(0))
      if rgba.size == 0
        rgba = Bytes.new(width * height * 4, 0)
      end

      self.new(width: width, height: height, rgba: rgba)
    end

    # Loads an image from a file or an `Gosu::ImageBlob` image.
    #
    # NOTE: For Windows Bitmap (BMP) images, magenta (FF00FF, often called "magic pink" in this context) is treated as a chroma key and all pixels of that color are automatically rendered fully transparent.
    #
    # `source` the filename or RMagick image to load from.
    #
    # `retro` if true, the image will not be interpolated when it is scaled up or down. When :retro it set, :tileable has no effect.
    #
    # `tileable` if true, the Image will not have soft edges when scaled
    #
    # See: `#load_tiles`
    #
    # See: `#from_text`
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#tileability Tileability explained in the Gosu Wiki
    def initialize(filename : String, retro : Bool = false, tileable : Bool = false)
      raise "Can not open file: #{filename}" unless File.exists?(filename)
      @__image = ImageC.create_image(filename, Gosu.image_flags(retro, tileable))
    end

    def initialize(pointer : UInt8*)
      @__image = pointer
    end

    def initialize(width : Int32, height : Int32, rgba : Bytes, image_flags : UInt32 = Gosu.image_flags)
      @__image = ImageC.create_image_from_blob(rgba, width * height * 4, width, height, image_flags)
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
    #
    # See `draw_as_quad`
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#z-ordering Z-ordering explained in the Gosu Wiki
    def draw(x : Float64 | Int32, y : Float64 | Int32, z : Float64 | Int32,
             scale_x : Float64 | Int32 = 1.0, scale_y : Float64 | Int32 = 1.0, color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE,
             mode : Symbol = :default)
      ImageC.draw(pointer, x.to_f64, y.to_f64, z.to_f64, scale_x.to_f64, scale_y.to_f64, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    # Draws the image rotated, with its rotational center at (x, y).
    #
    # `center_x` the relative horizontal rotation origin.
    #
    # `center_y` the relative vertical rotation origin.
    #
    # See `#draw`
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#z-ordering Z-ordering explained in the Gosu Wiki
    def draw_rot(x : Float64 | Int32, y : Float64 | Int32, z : Float64 | Int32,
                 angle : Float64 | Int32, center_x : Float64 | Int32 = 0.5, center_y : Float64 | Int32 = 0.5,
                 scale_x : Float64 | Int32 = 1, scale_y : Float64 | Int32 = 1, color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE,
                 mode : Symbol = :default)
      ImageC.draw_rot(pointer, x.to_f64, y.to_f64, z.to_f64, angle.to_f64, center_x.to_f64, center_y.to_f64, scale_x.to_f64, scale_y.to_f64, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    # Draws the image as an arbitrary quad. This method can be used for advanced non-rectangular drawing techniques, e.g., faking perspective or isometric projection.
    #
    # See `#draw`
    #
    # See `Gosu.draw_quad`
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#order-of-corners The order of corners explained in the Gosu Wiki
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#z-ordering Z-ordering explained in the Gosu Wiki
    def draw_as_quad(x1 : Float64 | Int32, y1 : Float64 | Int32, c1 : Gosu::Color | Int64 | UInt32,
                     x2 : Float64 | Int32, y2 : Float64 | Int32, c2 : Gosu::Color | Int64 | UInt32,
                     x3 : Float64 | Int32, y3 : Float64 | Int32, c3 : Gosu::Color | Int64 | UInt32,
                     x4 : Float64 | Int32, y4 : Float64 | Int32, c4 : Gosu::Color | Int64 | UInt32,
                     z : Float64 | Int32, mode : Symbol = :default)
      ImageC.draw_as_quad(x1.to_f64, y1.to_f64, Gosu.color_to_drawop(c1),
        x2.to_f64, y2.to_f64, Gosu.color_to_drawop(c2),
        x3.to_f64, y3.to_f64, Gosu.color_to_drawop(c3),
        x4.to_f64, y4.to_f64, Gosu.color_to_drawop(c4),
        z.to_f64, Gosu.blend_mode(mode))
    end

    # Returns the image's width, in pixels.
    def width
      ImageC.width(pointer)
    end

    # Returns the image's height, in pixels.
    def height
      ImageC.height(pointer)
    end

    # Returns the associated texture contents as binary string of packed RGBA values.
    def to_blob
      Bytes.new(ImageC.to_blob(pointer), width * height * 4)
    end

    # Saves the image to a file. The file format is determined from the file extension.
    #
    # Useful for, e.g., pre-rendering text on a development machine where the necessary fonts are known to be available.
    #
    # `filename` the path to save the file under.
    def save(filename : String)
      ImageC.save(pointer, filename)
    end

    # Overwrites part of the image with the contents of another. If the source image is partially out of bounds, it will be clipped to fit.
    #
    # This can be used to e.g. overwrite parts of a landscape.
    #
    # `source` the filename, `Gosu::Image`, or `Gosu::ImageBlob` image to load from.
    #
    # `x` the X coordinate of the top left corner.
    #
    # `y` the Y coordinate of the top left corner.
    def insert(other : Gosu::Image, x : Int32 | Float64, y : Int32 | Float64)
      ImageC.insert(pointer, other.pointer, x.to_i, y.to_i)
    end

    # Returns an image that is a smaller, rectangular view of this `Gosu::Image`.
    #
    # This is a very fast operation, and no new textures will be allocated.
    # If you update this `Gosu::Image` or the `#subimage` using `#insert`, the other `Gosu::Image` will be affected as well.
    #
    # Caveats:
    # * If you stretch or rotate a `#subimage`, the pixels adjacent to it might bleed into it, as Gosu does not manage the 'tileability' of subimages.
    def subimage(left : Int32, top : Int32, width : Int32, height : Int32) : Gosu::Image
      Gosu::Image.new(ImageC.subimage(pointer, left, top, width, height))
    end

    # Returns an object that holds information about the underlying OpenGL texture and UV coordinates of the image.
    #
    # NOTE: Some images may be too large to fit on a single texture; this method returns nil in those cases.
    #
    # See `Gosu::GLTexInfo`
    def gl_tex_info
      tex_info = ImageC.gl_tex_info_create(pointer)
      tex_info ? tex_info.value : nil
    end

    # :nodoc:
    def finalize
      ImageC.destroy_image(pointer)
    end
  end
end
