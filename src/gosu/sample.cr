module Gosu
  @[Link("gosu")]
  lib SampleC
    fun create_sample = Gosu_Sample_create(filename : UInt8*) : UInt8*
    fun destroy_sample = Gosu_Sample_destroy(pointer : UInt8*)

    fun play = Gosu_Sample_play(pointer : UInt8*, volume : Float64, speed : Float64, looping : Bool) : UInt8*
    fun play_pan = Gosu_Sample_play_pan(pointer : UInt8*, pan : Float64, volume : Float64, speed : Float64, looping : Bool) : UInt8*
  end

  class Sample
    def initialize(filename : String)
      raise "Can not open file: #{filename}" unless File.exists?(filename)

      @__sample = SampleC.create_sample(filename)
    end

    # :nodoc:
    def pointer
      @__sample
    end

    def play(volume : Float64 = 1.0, speed : Float64 = 1.0, looping : Bool = false) : Gosu::Channel
      Gosu::Channel.new(SampleC.play(pointer, volume, speed, looping))
    end

    def play_pan(pan : Float64 = 0.0, volume : Float64 = 1.0, speed : Float64 = 1.0, looping : Bool = false) : Gosu::Channel
      Gosu::Channel.new(SampleC.play_pan(pointer, pan, volume, speed, looping))
    end

    # :nodoc:
    def release
      SampleC.destroy_sample(pointer)
    end
  end
end
