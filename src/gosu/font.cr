module Gosu
  @[Link("gosu")]
  lib FontC
    fun create_font = Gosu_Font_create(line_height : Int32, name : UInt8*, font_flags : UInt32) : UInt8*

    fun name = Gosu_Font_name(pointer : UInt8*) : UInt8*
    fun height = Gosu_Font_height(pointer : UInt8*) : Int32
    fun flags = Gosu_Font_flags(pointer : UInt8*) : UInt32

    fun text_width = Gosu_Font_text_width(pointer : UInt8*, text : UInt8*) : Float64
    fun markup_width = Gosu_Font_markup_width(pointer : UInt8*, text : UInt8*) : Float64

    fun draw_text = Gosu_Font_draw_text(pointer : UInt8*, text : UInt8*, x : Float64, y : Float64, z : Float64,
                                        scale_x : Float64, scale_y : Float64, color : UInt32, mode : UInt32)
    fun draw_markup = Gosu_Font_draw_markup(pointer : UInt8*, text : UInt8*, x : Float64, y : Float64, z : Float64,
                                            scale_x : Float64, scale_y : Float64, color : UInt32, mode : UInt32)
    fun draw_text_rel = Gosu_Font_draw_text_rel(pointer : UInt8*, text : UInt8*, x : Float64, y : Float64, z : Float64,
                                                rel_x : Float64, rel_y : Float64, scale_x : Float64, scale_y : Float64,
                                                color : UInt32, mode : UInt32)
    fun draw_markup_rel = Gosu_Font_draw_markup_rel(pointer : UInt8*, text : UInt8*, x : Float64, y : Float64, z : Float64,
                                                    rel_x : Float64, rel_y : Float64, scale_x : Float64, scale_y : Float64,
                                                    color : UInt32, mode : UInt32)

    fun set_image = Gosu_Font_set_image(pointer : UInt8*, codepoint : UInt8*, font_flags : UInt32, image : UInt8*)

    fun destroy_font = Gosu_Font_destroy(pointer : UInt8*)
  end

  # A Font can be used to draw text on a Window object very flexibly.
  # Fonts are ideal for small texts that change regularly.
  # For large, static texts you should use `Gosu::Image#from_text`.
  class Font
    # Load a font from the system fonts or a file.
    #
    # height: the height of the font, in pixels.
    #
    # name: the name of a system font, or a path to a TrueType Font (TTF) file. A path must contain at least one '/' or '.' character to distinguish it from a system font.
    def initialize(height : Int32, name : String = Gosu.default_font_name, bold : Bool = false, italic : Bool = false, underline : Bool = false)
      @__font = FontC.create_font(height, name, Gosu.font_flags(bold, italic, underline))
    end

    # :nodoc:
    def pointer
      @__font
    end

    # Returns the font's name. This may be the name of a system font or a filename.
    def name : String
      String.new(FontC.name(pointer))
    end

    # Returns the font's height in pixels.
    def height : Int32
      FontC.height(pointer)
    end

    # Returns the flags passed to `Gosu::Font` as a UInt32
    def flags : UInt32
      FontC.flags(pointer)
    end

    # Returns the width of a single line of text, in pixels, if it were drawn.
    def text_width(text) : Float64
      FontC.text_width(pointer, text)
    end

    # Like `#text_width`, but supports the following markup tags: <b>**bold**</b>, <i>*italic*</i>, and <c=rrggbb>colors</c>.
    def markup_width(markup) : Float64
      FontC.markup_width(pointer, markup)
    end

    # Draws a single line of text with its top left corner at (x, y).
    #
    # SEE: `#draw_text_rel`
    #
    # SEE: `Gosu::Image.from_text`
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#z-ordering Z-ordering explained in the Gosu Wiki
    def draw_text(text : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                  scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                  color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_text(pointer, text, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    # Like `#draw_text`, but supports the following markup tags: <b>**bold**</b>, <i>*italic*</i>, and <c=rrggbb>colors</c>.
    def draw_markup(markup : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                    scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                    color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_markup(pointer, markup, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    # Draws a single line of text relative to (x, y).
    #
    # The text is aligned to the drawing location according to the `rel_x` and `rel_y` parameters: a value of 0.0 corresponds to top and left, while 1.0 corresponds to bottom and right. A value of 0.5 naturally corresponds to the center of the text.
    #
    # All real numbers are valid alignment values and will be interpolated (or extrapolated) accordingly.
    #
    # SEE: `#draw_text`
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#drawing-with-colours Drawing with colors, explained in the Gosu Wiki
    # NOTE: https://github.com/gosu/gosu/wiki/Basic-Concepts#z-ordering Z-ordering explained in the Gosu Wiki
    def draw_text_rel(text : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                      rel_x : Int32 | Float64, rel_y : Int32 | Float64,
                      scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                      color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_text_rel(pointer, text, x, y, z, rel_x, rel_y, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    # Like `#draw_text_rel`, but supports the following markup tags: <b>**bold**</b>, <i>*italic*</i>, and <c=rrggbb>colors</c>.
    def draw_markup_rel(markup : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                        rel_x : Int32 | Float64, rel_y : Int32 | Float64,
                        scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                        color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_markup_rel(pointer, markup, x, y, z, rel_x, rel_y, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    # Overrides the image for a character.
    #
    # NOTE: For any given character, this method MUST NOT be called more than once, and MUST NOT be called if a string containing the character has already been drawn.
    def []=(codepoint : String, image : Gosu::Image)
      FontC.set_image(pointer, codepoint, self.flags, image.pointer)
    end

    # :nodoc:
    def release
      FontC.destroy_font(pointer)
    end
  end
end
