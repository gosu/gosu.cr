module Gosu
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

  # `Sample#play` returns a Channel that represents the sound currently being played.
  #
  # This object can be used to stop sounds dynamically, or to check whether they have finished.
  class Channel
    def initialize(pointer : UInt8*)
      @__channel = pointer
    end

    # :nodoc:
    def pointer
      @__channel
    end

    # Returns whether the sample is playing.
    def playing?
      ChannelC.playing(pointer)
    end

    # Pauses the sample, to be resumed afterwards.
    #
    # NOTE: The sample will still occupy a playback channel while paused.
    def pause
      ChannelC.pause(pointer)
    end

    # Returns whether the sample is paused.
    def paused?
      ChannelC.paused(pointer)
    end

    # Resumes playback of the sample.
    def resume
      ChannelC.resume(pointer)
    end

    # Stops playback of this sample instance. After calling this method, the sample instance is useless and can be discarded.
    #
    # Calling `stop` after the sample has finished is harmless and has no effect.
    def stop
      ChannelC.stop(pointer)
    end

    # Sets the playback volume, in the range [0.0; 1.0], where 0 is completely silent
    # and 1 is full volume. Values outside of this range will be clamped to [0.0; 1.0].
    def volume=(double : Float64)
      ChannelC.set_volume(pointer, double)
    end

    # Sets the playback speed. A value of 2.0 will play the sample at 200% speed and one octave higher.
    # A value of 0.5 will play the sample at 50% speed and one octave lower. The valid range of this
    # property depends on the operating system, but values up to 8.0 should work.
    def speed=(double : Float64)
      ChannelC.set_speed(pointer, double)
    end

    # Set the amount of panning, i.e. the position of the sound when using stereo speakers. 0.0 is the centre,
    # negative values are to the left, positive values are to the right. If something happens on the
    # edge of the screen, a good value for pan would be ±0.1.
    def pan=(double : Float64)
      ChannelC.set_pan(pointer, double)
    end

    # :nodoc:
    def release
      ChannelC.channel_destroy(pointer)
    end
  end
end
