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
      song = SongC.current_song
      if song
        Gosu::Song.new(song)
      else
        nil
      end
    end

    @__song : UInt8*

    def initialize(filename_or_pointer : String | UInt8*)
      if filename_or_pointer.is_a?(String)
        @__song = SongC.create_song(filename_or_pointer)
      elsif filename_or_pointer.is_a?(Pointer(UInt8))
        @__song = filename_or_pointer
      else
        raise "Expected a filename or a pointer to another Gosu::Song"
      end
    end

    def play(looping : Bool = false)
      SongC.song_play(@__song, looping)
    end

    def playing? : Bool
      SongC.song_playing(@__song)
    end

    def pause
      SongC.song_pause(@__song)
    end

    def paused? : Bool
      SongC.song_paused(@__song)
    end

    def volume : Float64
      SongC.song_volume(@__song)
    end

    def volume=(double : Float64)
      SongC.song_set_volume(@__song, double.clamp(0.0, 1.0))
    end

    def stop
      SongC.song_stop(@__song)
    end

    # :nodoc:
    def finalize
      SongC.destroy_song(@__song)
    end
  end
end
