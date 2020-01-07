module Gosu
  @[Link("gosu")]
  lib SongC
    fun create_song = Gosu_Song_create(filename : UInt8*) : UInt8*
    fun destroy_song = Gosu_Song_destroy(song : UInt8*)

    fun current_song = Gosu_Song_current_song : UInt8*

    fun song_play = Gosu_Song_play(song : UInt8*, looping : Bool)
    fun song_playing = Gosu_Song_playing(song : UInt8*) : Bool
    fun song_pause = Gosu_Song_pause(song : UInt8*)
    fun song_paused = Gosu_Song_paused(song : UInt8*) : Bool
    fun song_stop = Gosu_Song_stop(song : UInt8*)

    fun song_volume = Gosu_Song_volume(song : UInt8*) : Float64
    fun song_set_volume = Gosu_Song_set_volume(song : UInt8*, volume : Float64)
  end

  class Song
    def self.current_song : Gosu::Song?
      if SongC.current_song
        @@current_song
      else
        nil
      end
    end

    @@current_song : Gosu::Song?

    def initialize(filename : String)
      raise "Can not open file: #{filename}" unless File.exists?(filename)

      @__song = SongC.create_song(filename)
    end

    # :nodoc:
    def pointer
      @__song
    end

    def play(looping : Bool = false)
      @@current_song = self
      SongC.song_play(pointer, looping)
    end

    def playing? : Bool
      SongC.song_playing(pointer)
    end

    def pause
      SongC.song_pause(pointer)
    end

    def paused? : Bool
      SongC.song_paused(pointer)
    end

    def volume : Float64
      SongC.song_volume(pointer)
    end

    def volume=(double : Float64)
      SongC.song_set_volume(pointer, double.clamp(0.0, 1.0))
    end

    def stop
      SongC.song_stop(pointer)
    end

    # :nodoc:
    def finalize
      SongC.destroy_song(pointer)
    end
  end
end
