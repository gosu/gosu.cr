require "./gosu/window"
require "./gosu/image"

# require "./gosu/window"

module Gosu
  @[Link("gosu")]
  lib GosuC
    fun fps = Gosu_fps() : UInt32
  end

  def self.fps
    GosuC.fps
  end
end
