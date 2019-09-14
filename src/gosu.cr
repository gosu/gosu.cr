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
  end

  # Returns the current framerate, in frames per second.
  def self.fps : UInt32
    GosuC.fps
  end

  # Returns whether the button `id` is currently pressed.
  def self.button_down?(id : UInt32) : Bool
  end
end
