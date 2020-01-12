module Gosu
  @[Link("gosu")]
  lib SampleC
    fun create_sample = Gosu_Sample_create(filename : UInt8*) : UInt8*
    fun destroy_sample = Gosu_Sample_destroy(pointer : UInt8*)

    fun play = Gosu_Sample_play(pointer : UInt8*, volume : Float64, speed : Float64, looping : Bool) : UInt8*
    fun play_pan = Gosu_Sample_play_pan(pointer : UInt8*, pan : Float64, volume : Float64, speed : Float64, looping : Bool) : UInt8*
  end

  # A sample is a short sound that is completely loaded in memory, can be
  # played multiple times at once and offers very flexible playback
  # parameters. Use samples for everything that's not music.
  #
  # See `Gosu::Song`
  class Sample
    # Loads a sample from a file.
    def initialize(filename : String)
      raise "Can not open file: #{filename}" unless File.exists?(filename)

      @__sample = SampleC.create_sample(filename)
    end

    # :nodoc:
    def pointer
      @__sample
    end

    # Plays the sample without panning.
    #
    # `volume` see `Channel#volume=`
    #
    # `speed` see `Channel#speed=`
    #
    # `looping` whether the sample should play in a loop. If you pass true, be sure
    # to store the return value of this method so that you can later stop the looping sound.
    #
    # See `#play_pan`
    def play(volume : Float64 = 1.0, speed : Float64 = 1.0, looping : Bool = false) : Gosu::Channel
      Gosu::Channel.new(SampleC.play(pointer, volume, speed, looping))
    end

    # Plays the sample with panning.
    #
    # `pan` see `Channel#pan=`
    #
    # `volume` see `Channel#volume=`
    #
    # `speed` see `Channel#speed=`
    #
    # `looping` whether the sample should play in a loop. If you pass true, be sure
    # to store the return value of this method so that you can later stop the looping sound.
    #
    # See `#play`
    def play_pan(pan : Float64 = 0.0, volume : Float64 = 1.0, speed : Float64 = 1.0, looping : Bool = false) : Gosu::Channel
      Gosu::Channel.new(SampleC.play_pan(pointer, pan, volume, speed, looping))
    end

    # :nodoc:
    def release
      SampleC.destroy_sample(pointer)
    end
  end
end
