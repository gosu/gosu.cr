module Gosu
  @[Link("gosu")]
  lib ChannelC
    fun channel_destroy = Gosu_Channel_destroy(pointer : UInt8*)

    fun playing = Gosu_Channel_playing(pointer : UInt8*) : Bool
    fun pause = Gosu_Channel_pause(pointer : UInt8*)
    fun paused = Gosu_Channel_paused(pointer : UInt8*) : Bool
    fun resume = Gosu_Channel_resume(pointer : UInt8*)
    fun stop = Gosu_Channel_stop(pointer : UInt8*)

    fun set_volume = Gosu_Channel_set_volume(pointer : UInt8*, volume : Float64)
    fun set_speed = Gosu_Channel_set_speed(pointer : UInt8*, speed : Float64)
    fun set_pan = Gosu_Channel_set_pan(pointer : UInt8*, pan : Float64)
  end

  class Channel
    def initialize(pointer : UInt8*)
      @__channel = pointer
    end

    # :nodoc:
    def pointer
      @__channel
    end

    def playing?
      ChannelC.playing(pointer)
    end

    def pause
      ChannelC.pause(pointer)
    end

    def paused?
      ChannelC.paused(pointer)
    end

    def resume
      ChannelC.resume(pointer)
    end

    def stop
      ChannelC.stop(pointer)
    end

    def volume=(double : Float64)
      ChannelC.set_volume(pointer, double)
    end

    def speed=(double : Float64)
      ChannelC.set_speed(pointer, double)
    end

    def pan=(double : Float64)
      ChannelC.set_pan(pointer, double)
    end

    # :nodoc:
    def release
      ChannelC.channel_destroy(pointer)
    end
  end
end
