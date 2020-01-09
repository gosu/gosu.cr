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

  class Font
    def initialize(height : Int32, name : String = Gosu.default_font_name, bold : Bool = false, italic : Bool = false, underline : Bool = false)
      @__font = FontC.create_font(height, name, Gosu.font_flags(bold, italic, underline))
    end

    # :nodoc:
    def pointer
      @__font
    end

    def name : String
      String.new(FontC.name(pointer))
    end

    def height : Int32
      FontC.height(pointer)
    end

    def flags : UInt32
      FontC.flags(pointer)
    end

    def text_width(text) : Float64
      FontC.text_width(pointer, text)
    end

    def markup_width(markup) : Float64
      FontC.markup_width(pointer, markup)
    end

    def draw_text(text : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                  scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                  color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_text(pointer, text, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    def draw_markup(markup : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                    scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                    color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_markup(pointer, markup, x, y, z, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    def draw_text_rel(text : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                      rel_x : Int32 | Float64, rel_y : Int32 | Float64,
                      scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                      color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_text_rel(pointer, text, x, y, z, rel_x, rel_y, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    def draw_markup_rel(markup : String, x : Int32 | Float64, y : Int32 | Float64, z : Int32 | Float64,
                        rel_x : Int32 | Float64, rel_y : Int32 | Float64,
                        scale_x : Int32 | Float64 = 1, scale_y : Int32 | Float64 = 1,
                        color : Gosu::Color | Int64 | UInt32 = Gosu::Color::WHITE, mode : Symbol = :default)
      FontC.draw_markup_rel(pointer, markup, x, y, z, rel_x, rel_y, scale_x, scale_y, Gosu.color_to_drawop(color), Gosu.blend_mode(mode))
    end

    def []=(codepoint : String, image : Gosu::Image)
      FontC.set_image(pointer, codepoint, self.flags, image.pointer)
    end

    # :nodoc:
    def release
      FontC.destroy_font(pointer)
    end
  end
end
