require "./gosu/color"
require "./gosu/window"
require "./gosu/text_input"
require "./gosu/image"

# require "./gosu/font"
# require "./gosu/song"
# require "./gosu/sample"
# require "./gosu/channel"

module Gosu
  # Returns version of gosu.cr shard
  SHARD_VERSION = "0.1.0"

  # Returns version of Gosu that gosu.cr was built against
  VERSION = "0.14.5"

  @[Link("gosu")]
  lib GosuC
    fun fps = Gosu_fps : UInt32

    fun button_down = Gosu_button_down(id : UInt32) : Bool
    fun milliseconds = Gosu_milliseconds : UInt64
    fun draw_rect = Gosu_draw_rect(x : Float64, y : Float64, width : Float64, height : Float64,
                                   color : UInt32, z : Float64, mode : UInt32)
  end

  # Returns the current framerate, in frames per second.
  def self.fps : UInt32
    GosuC.fps
  end

  # Returns whether the button `id` is currently pressed.
  def self.button_down?(id : UInt32) : Bool
    GosuC.button_down(id)
  end

  def self.milliseconds : UInt64
    GosuC.milliseconds
  end

  def self.draw_rect(x : Float64|Int32, y : Float64|Int32, width : Float64|Int32, height : Float64|Int32,
                     color : Gosu::Color|Int64|UInt32 = 0xff_ffffff, z : Float64|Int32 = 0, mode : UInt32 = 0)
    GosuC.draw_rect(x.to_f64, y.to_f64, width.to_f64, height.to_f64,
                    color.is_a?(Gosu::Color) ? color.gl : color, z.to_f64, mode)
  end
end
