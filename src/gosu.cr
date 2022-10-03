require "./gosu/constants"
require "./gosu/color"
require "./gosu/window"
require "./gosu/text_input"
require "./gosu/image"
require "./gosu/font"
require "./gosu/song"
require "./gosu/sample"
require "./gosu/channel"

# require "./gosu/gl_texinfo"

module Gosu
  # Returns version of gosu.cr shard
  SHARD_VERSION = "0.2.0"

  # Returns version of Gosu that gosu.cr was built/tested against
  VERSION = "1.2.0"

  {% if flag?(:windows) %}
    @[Link("gdi32")]
    @[Link("user32")]
    @[Link("Gosu")]
  {% end %}
  @[Link("gosu-ffi")]
  lib GosuC
    fun fps = Gosu_fps : UInt32
    fun flush = Gosu_flush : Void
    fun user_languages = Gosu_user_languages(function : (Void*, UInt8* ->), data : Void*) : UInt8*
    fun milliseconds = Gosu_milliseconds : UInt64
    fun default_font_name = Gosu_default_font_name : UInt8*

    fun transform = Gosu_transform(m0 : Float64, m1 : Float64, m2 : Float64, m3 : Float64,
                                   m4 : Float64, m5 : Float64, m6 : Float64, m7 : Float64,
                                   m8 : Float64, m9 : Float64, m10 : Float64, m11 : Float64,
                                   m12 : Float64, m13 : Float64, m14 : Float64, m15 : Float64,
                                   function : Void* ->, data : Void*)
    fun translate = Gosu_translate(x : Float64, y : Float64, function : Void* ->, data : Void*)
    fun rotate = Gosu_rotate(angle : Float64, around_x : Float64, around_y : Float64,
                             function : Void* ->, data : Void*)
    fun scale = Gosu_scale(scale_x : Float64, scale_y : Float64, around_x : Float64, around_y : Float64,
                           function : Void* ->, data : Void*)
    fun clip_to = Gosu_clip_to(x : Float64, y : Float64, width : Float64, height : Float64,
                               function : Void* ->, data : Void*)

    fun gl_z = Gosu_gl_z(double : Float64, function : Void* ->, data : Void*)
    fun gl = Gosu_gl(function : Void* ->, data : Void*)
    fun render = Gosu_render(width : Int32, height : Int32, function : Void* ->, data : Void*, image_flags : UInt32) : UInt8*
    fun record_ = Gosu_record(width : Int32, height : Int32, function : Void* ->, data : Void*) : UInt8*

    fun button_down = Gosu_button_down(id : UInt32) : Bool
    fun button_id_to_char = Gosu_button_id_to_char(id : UInt32) : UInt8*
    fun button_char_to_id = Gosu_button_char_to_id(char : UInt8*) : UInt32
    fun button_name = Gosu_button_name(id : UInt32) : UInt8*
    fun gamepad_name = Gosu_gamepad_name(id : UInt32) : UInt8*
    fun axis = Gosu_axis(id : UInt32) : Float64

    fun draw_line = Gosu_draw_line(x1 : Float64, y1 : Float64, c1 : UInt32,
                                   x2 : Float64, y2 : Float64, c2 : UInt32,
                                   z : Float64, mode : UInt32)
    fun draw_quad = Gosu_draw_quad(x1 : Float64, y1 : Float64, c1 : UInt32,
                                   x2 : Float64, y2 : Float64, c2 : UInt32,
                                   x3 : Float64, y3 : Float64, c3 : UInt32,
                                   x4 : Float64, y4 : Float64, c4 : UInt32,
                                   z : Float64, mode : UInt32)
    fun draw_triangle = Gosu_draw_triangle(x1 : Float64, y1 : Float64, c1 : UInt32,
                                           x2 : Float64, y2 : Float64, c2 : UInt32,
                                           x3 : Float64, y3 : Float64, c3 : UInt32,
                                           z : Float64, mode : UInt32)
    fun draw_rect = Gosu_draw_rect(x : Float64, y : Float64, width : Float64, height : Float64,
                                   color : UInt32, z : Float64, mode : UInt32)

    fun offset_x = Gosu_offset_x(theta : Float64, r : Float64) : Float64
    fun offset_y = Gosu_offset_y(theta : Float64, r : Float64) : Float64
    fun distance = Gosu_distance(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64) : Float64
    fun angle = Gosu_angle(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64) : Float64
    fun angle_diff = Gosu_angle_diff(angle1 : Float64, angle2 : Float64) : Float64
    fun random = Gosu_random(min : Float64, max : Float64) : Float64

    fun screen_width = Gosu_screen_width(window : UInt8*) : UInt32
    fun screen_height = Gosu_screen_height(window : UInt8*) : UInt32
    fun available_width = Gosu_available_width(window : UInt8*) : UInt32
    fun available_height = Gosu_available_height(window : UInt8*) : UInt32

    fun clipboard = Gosu_clipboard() : UInt8*
    fun set_clipboard = Gosu_set_clipboard(text : UInt8*)

    fun last_error = Gosu_last_error() : UInt8*
  end

  # Returns the current framerate, in frames per second.
  def self.fps : UInt32
    GosuC.fps
  end

  def self.flush
    GosuC.flush
  end

  def self.user_languages : Array(String)
    languages = [] of String

    proc = ->(language : UInt8*) { languages << String.new(language) }
    box = Box.box(proc)

    GosuC.user_languages(->(data : Void*, language : UInt8*) {
      callback = Box(typeof(proc)).unbox(data)
      callback.call(language)
    }, box)

    languages
  end

  @[Deprecated("Use `#user_languages` instead")]
  def self.language : String
    @@language_cache ||= (user_languages.first? || "en_US")
  end

  def self.milliseconds : UInt64
    GosuC.milliseconds
  end

  def self.default_font_name : String
    String.new(GosuC.default_font_name)
  end

  def self.gl(z : Float64?, &block)
    box = Box.box(block)

    if z
      GosuC.gl_z(z.to_f64, ->(data : Void*) {
        callback = Box(typeof(block)).unbox(data)
        callback.call
      }, box)
    else
      GosuC.gl(->(data : Void*) {
        callback = Box(typeof(block)).unbox(data)
        callback.call
      }, box)
    end
  end

  def self.transform(m0 : Float64 | Int32, m1 : Float64 | Int32, m2 : Float64 | Int32, m3 : Float64 | Int32,
                     m4 : Float64 | Int32, m5 : Float64 | Int32, m6 : Float64 | Int32, m7 : Float64 | Int32,
                     m8 : Float64 | Int32, m9 : Float64 | Int32, m10 : Float64 | Int32, m11 : Float64 | Int32,
                     m12 : Float64 | Int32, m13 : Float64 | Int32, m14 : Float64 | Int32, m15 : Float64 | Int32, &block)
    box = Box.box(block)

    GosuC.transform(m0.to_f64, m1.to_f64, m2.to_f64, m3.to_f64, m4.to_f64, m5.to_f64, m6.to_f64, m7.to_f64,
      m8.to_f64, m9.to_f64, m10.to_f64, m11.to_f64, m12.to_f64, m13.to_f64, m14.to_f64, m15.to_f64,
      ->(data : Void*) {
        callback = Box(typeof(block)).unbox(data)
        callback.call
      }, box)
  end

  def self.translate(x : Float64 | Int32, y : Float64 | Int32, &block)
    box = Box.box(block)

    GosuC.translate(x.to_f64, y.to_f64, ->(data : Void*) {
      callback = Box(typeof(block)).unbox(data)
      callback.call
    }, box)
  end

  def self.rotate(angle : Float64 | Int32, around_x : Float64 | Int32 = 0, around_y : Float64 | Int32 = 0, &block)
    box = Box.box(block)

    GosuC.rotate(angle.to_f64, around_x.to_f64, around_y.to_f64, ->(data : Void*) {
      callback = Box(typeof(block)).unbox(data)
      callback.call
    }, box)
  end

  def self.scale(scale_x : Float64 | Int32, scale_y : Float64 | Int32,
                 around_x : Float64 | Int32 = 0, around_y : Float64 | Int32 = 0, &block)
    box = Box.box(block)

    GosuC.scale(scale_x.to_f64, scale_y.to_f64, around_x.to_f64, around_y.to_f64, ->(data : Void*) {
      callback = Box(typeof(block)).unbox(data)
      callback.call
    }, box)
  end

  def self.clip_to(x : Float64 | Int32, y : Float64 | Int32, width : Float64 | Int32, height : Float64 | Int32, &block)
    box = Box.box(block)

    GosuC.clip_to(x.to_f64, y.to_f64, width.to_f64, height.to_f64, ->(data : Void*) {
      callback = Box(typeof(block)).unbox(data)
      callback.call
    }, box)
  end

  def self.render(width : Int32, height : Int32, retro : Bool = false, &block) : Gosu::Image
    box = Box.box(block)

    image = GosuC.render(width, height, ->(data : Void*) {
      callback = Box(typeof(block)).unbox(data)
      callback.call
    }, box, Gosu.image_flags(retro))

    return Gosu::Image.new(image)
  end

  def self.record(width : Int32, height : Int32, &block) : Gosu::Image
    box = Box.box(block)

    image = GosuC.record_(width, height, ->(data : Void*) {
      callback = Box(typeof(block)).unbox(data)
      callback.call
    }, box)

    return Gosu::Image.new(image)
  end

  # Returns whether the button `id` is currently pressed.
  def self.button_down?(id : UInt32) : Bool
    GosuC.button_down(id)
  end

  def self.button_id_to_char(id : UInt32) : String
    String.new(GosuC.button_id_to_char(id))
  end

  def self.char_to_button_id(char : String) : UInt32
    GosuC.button_char_to_id(char)
  end

  def self.button_name(id : UInt32) : String
    String.new(GosuC.button_name(id))
  end

  def self.gamepad_name(id : UInt32) : String
    String.new(GosuC.gamepad_name(id))
  end

  def self.axis(id : UInt32) : Float64
    GosuC.axis(id)
  end

  def self.draw_line(x1 : Float64 | Int32, y1 : Float64 | Int32, c1 : Gosu::Color | Int64 | UInt32,
                     x2 : Float64 | Int32, y2 : Float64 | Int32, c2 : Gosu::Color | Int64 | UInt32,
                     z : Float64 | Int32 = 0, mode : UInt32 | Symbol = :default)
    GosuC.draw_line(x1.to_f64, y1.to_f64, color_to_drawop(c1),
      x2.to_f64, y2.to_f64, color_to_drawop(c2),
      z.to_f64, blend_mode(mode))
  end

  def self.draw_quad(x1 : Float64 | Int32, y1 : Float64 | Int32, c1 : Gosu::Color | Int64 | UInt32,
                     x2 : Float64 | Int32, y2 : Float64 | Int32, c2 : Gosu::Color | Int64 | UInt32,
                     x3 : Float64 | Int32, y3 : Float64 | Int32, c3 : Gosu::Color | Int64 | UInt32,
                     x4 : Float64 | Int32, y4 : Float64 | Int32, c4 : Gosu::Color | Int64 | UInt32,
                     z : Float64 | Int32 = 0, mode : UInt32 | Symbol = :default)
    GosuC.draw_quad(x1.to_f64, y1.to_f64, color_to_drawop(c1),
      x2.to_f64, y2.to_f64, color_to_drawop(c2),
      x3.to_f64, y3.to_f64, color_to_drawop(c3),
      x4.to_f64, y4.to_f64, color_to_drawop(c4),
      z.to_f64, blend_mode(mode))
  end

  def self.draw_triangle(x1 : Float64 | Int32, y1 : Float64 | Int32, c1 : Gosu::Color | Int64 | UInt32,
                         x2 : Float64 | Int32, y2 : Float64 | Int32, c2 : Gosu::Color | Int64 | UInt32,
                         x3 : Float64 | Int32, y3 : Float64 | Int32, c3 : Gosu::Color | Int64 | UInt32,
                         z : Float64 | Int32 = 0, mode : UInt32 | Symbol = :default)
    GosuC.draw_triangle(x1.to_f64, y1.to_f64, color_to_drawop(c1),
      x2.to_f64, y2.to_f64, color_to_drawop(c2),
      x3.to_f64, y3.to_f64, color_to_drawop(c3),
      z.to_f64, blend_mode(mode))
  end

  def self.draw_rect(x : Float64 | Int32, y : Float64 | Int32, width : Float64 | Int32, height : Float64 | Int32,
                     color : Gosu::Color | Int64 | UInt32 = 0xff_ffffff, z : Float64 | Int32 = 0, mode : UInt32 | Symbol = :default)
    GosuC.draw_rect(x.to_f64, y.to_f64, width.to_f64, height.to_f64,
      color_to_drawop(color), z.to_f64, blend_mode(mode))
  end

  def self.offset_x(theta : Float64 | Int32, r : Float64 | Int32) : Float64
    GosuC.offset_x(theta.to_f64, r.to_f64)
  end

  def self.offset_y(theta : Float64 | Int32, r : Float64 | Int32) : Float64
    GosuC.offset_y(theta.to_f64, r.to_f64)
  end

  def self.distance(x1 : Float64 | Int32, y1 : Float64 | Int32,
                    x2 : Float64 | Int32, y2 : Float64 | Int32) : Float64
    GosuC.distance(x1.to_f64, y1.to_f64, x2.to_f64, y2.to_f64)
  end

  def self.angle(x1 : Float64 | Int32, y1 : Float64 | Int32,
                 x2 : Float64 | Int32, y2 : Float64 | Int32) : Float64
    GosuC.angle(x1.to_f64, y1.to_f64, x2.to_f64, y2.to_f64)
  end

  def self.angle_diff(angle1 : Float64 | Int32, angle2 : Float64 | Int32) : Float64
    GosuC.angle_diff(angle1.to_f64, angle2.to_f64)
  end

  def self.random(min : Float64 | Int32, max : Float64 | Int32) : Float64
    GosuC.random(min.to_f64, max.to_f64)
  end

  def self.screen_width(window : UInt8* = Pointer(UInt8).null) : UInt32
    GosuC.screen_width(window)
  end

  def self.screen_height(window : UInt8* = Pointer(UInt8).null) : UInt32
    GosuC.screen_height(window)
  end

  def self.available_width(window : UInt8* = Pointer(UInt8).null) : UInt32
    GosuC.available_width(window)
  end

  def self.available_height(window : UInt8* = Pointer(UInt8).null) : UInt32
    GosuC.available_height(window)
  end

  def clipboard : String
    String.new(GosuC.clipboard(pointer))
  end

  def clipboard=(text : String)
    GosuC.set_clipboard(text)
  end

  def self.color_to_drawop(color : Gosu::Color | Int64 | UInt32)
    color.is_a?(Gosu::Color) ? color.gl : color
  end

  def self.window_flags(fullscreen = false, resizable = false, borderless = false) : UInt32
    flags = 0_u32

    flags |= 1 if fullscreen
    flags |= 2 if resizable
    flags |= 4 if borderless

    return flags
  end

  # SEE: https://github.com/gosu/gosu/blob/master/Gosu/GraphicsBase.hpp
  def self.image_flags(retro : Bool = false, tileable : Bool = false) : UInt32
    flags = 0.to_u32

    flags |= 1 << 5 if retro
    flags |= 1 << 8 if tileable

    return flags
  end

  def self.font_flags(bold, italic, underline) : UInt32
    flags = 0.to_u32
    flags |= 1 if bold
    flags |= 2 if italic
    flags |= 4 if underline

    return flags
  end

  def self.font_alignment_flags(mode) : UInt32
    case mode
    when :left
      0_u32
    when :right
      1_u32
    when :center
      2_u32
    when :justify
      3_u32
    else
      return mode if mode.is_a?(UInt32)
      raise "No such mode: #{mode}"
    end
  end

  # Converts `mode` to number.
  # Valid  blend modes are: `:default` and `:additive`.
  def self.blend_mode(mode : Symbol) : UInt32
    case mode
    when :default
      0_u32
    when :additive, :add
      1_u32
    when :multiply
      2_u32
    else
      return mode if mode.is_a?(UInt32)
      raise "No such mode: #{mode}"
    end
  end

  def self.check_last_error
    if (err = GosuC.last_error)
      raise String.new(err)
    end
  end
end
