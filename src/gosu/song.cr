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

  # Songs are less flexible than samples in that only one can be played at a time, with no panning or speed control.
  #
  # See `Gosu::Sample`
  class Song
    # Returns the song currently being played (even if it's paused), or nil if no song is playing.
    def self.current_song : Gosu::Song?
      if SongC.current_song
        @@current_song
      else
        nil
      end
    end

    @@current_song : Gosu::Song?

    # Loads a song from a file.
    def initialize(filename : String)
      raise "Can not open file: #{filename}" unless File.exists?(filename)

      @__song = SongC.create_song(filename)
    end

    # :nodoc:
    def pointer
      @__song
    end

    # Starts or resumes playback of the song.
    #
    # If another song is currently playing, it will be stopped and this song will be set as the current song.
    #
    # If `looping` is false, the current song will be set to `nil` when this song finishes.
    #
    # `looping` whether the song should play in a loop.
    def play(looping : Bool = false)
      @@current_song = self
      SongC.song_play(pointer, looping)
    end

    # Returns whether the song is playing.
    def playing? : Bool
      SongC.song_playing(pointer)
    end

    # Pauses playback of the song. The current song is unchanged.
    def pause
      SongC.song_pause(pointer)
    end

    # Returns true if this song is the current song and playback is paused.
    def paused? : Bool
      SongC.song_paused(pointer)
    end


    # Returns the song's playback volume.
    def volume : Float64
      SongC.song_volume(pointer)
    end

    # Sets the song's playback volume.
    def volume=(double : Float64)
      SongC.song_set_volume(pointer, double.clamp(0.0, 1.0))
    end

    # Stops playback if this song is the current song. The current song is set to `nil`.
    def stop
      SongC.song_stop(pointer)
    end

    # :nodoc:
    def finalize
      SongC.destroy_song(pointer)
    end
  end
end
