module Gosu
  @[Link("gosu")]
  lib WindowC
    fun create_window      = Gosu_Window_create(width : Int32, height : Int32, fullscreen : Bool, update_interval : Float64, resizable : Bool) : UInt8*
    fun window_show        = Gosu_Window_show(window : UInt8*)
    fun window_set_caption = Gosu_Window_set_caption(window : UInt8*, text : UInt8*)
    fun window_set_draw    = Gosu_Window_set_draw(window : UInt8*, function : Void*)
    fun window_set_update  = Gosu_Window_set_update(window : UInt8*, function : Void*)
    fun destroy_window     = Gosu_Window_destroy(window : UInt8*)

    # fun callback(function: Void* ->)
  end

  class Window
    @@boxed_draw : Pointer(Void)?

    def initialize(width, height, fullscreen = false, update_interval = 16.66666667, resizable = false)
      @__pointer = WindowC.create_window(width, height, fullscreen, update_interval, resizable)

      f = -> { draw } # This method of passing Proc is incorrect as context is lost
      WindowC.window_set_draw(@__pointer, f.pointer)
      f = -> { update }
      WindowC.window_set_update(@__pointer, f.pointer)
    end

    def draw
    end

    def update
    end

    def button_down?(id : UInt32) : Bool
    end

    def button_down(id : UInt32)
    end

    def button_up(id : UInt32)
    end

    def needs_redraw? : Bool
    end

    def needs_cursor? : Bool
    end

    def drop(filename : String)
    end

    def close : Bool
    end

    def close!
    end

    def width : Int32
    end

    def height : Int32
    end

    def width=(int : Int32)
    end

    def height=(int : Int32)
    end

    def fullscreen? : Bool
    end

    def fullscreen=(boolean : Bool)
    end

    def resizable? : Bool
    end

    def caption : String
    end

    def caption=(string : String)
      WindowC.window_set_caption(@__pointer, string)
    end

    def mouse_x : Float64
    end

    def mouse_x=(double : Float64)
    end

    def mouse_y : Float64
    end

    def mouse_y=(double : Float64)
    end

    def resize(width : Int32, height : Int32, resizable : Bool)
    end

    def show
      WindowC.window_show(@__pointer)
    end

    def tick : Bool
    end

    def finalize
      WindowC.destroy_window(@__pointer)
    end
  end
end