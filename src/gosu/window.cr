module Gosu
  @[Link("gosu")]
  lib WindowC
    fun create_window = Gosu_Window_create(width : Int32, height : Int32, fullscreen : Bool, update_interval : Float64, resizable : Bool) : UInt8*
    fun window_show = Gosu_Window_show(window : UInt8*)
    fun window_tick = Gosu_Window_tick(window : UInt8*) : Bool
    fun window_caption = Gosu_Window_caption(window : UInt8*) : UInt8*
    fun window_set_caption = Gosu_Window_set_caption(window : UInt8*, text : UInt8*)

    fun window_set_draw = Gosu_Window_set_draw(window : UInt8*, function : Void*)
    fun window_set_update = Gosu_Window_set_update(window : UInt8*, function : Void*)

    fun window_width = Gosu_Window_width(window : UInt8*) : Int32
    fun window_height = Gosu_Window_height(window : UInt8*) : Int32
    fun window_set_width = Gosu_Window_set_width(window : UInt8*, width : Int32)
    fun window_set_height = Gosu_Window_set_height(window : UInt8*, height : Int32)

    fun destroy_window = Gosu_Window_destroy(window : UInt8*)

    # fun callback(function: Void* ->)
  end

  class Window
    @@boxed_draw : Pointer(Void)?

    def initialize(width, height, fullscreen = false, update_interval = 16.66666667, resizable = false)
      @__pointer = WindowC.create_window(width, height, fullscreen, update_interval, resizable)

      f = ->{ draw } # This method of passing Proc is incorrect as context is lost
      WindowC.window_set_draw(@__pointer, f.pointer)
      f = ->{ update }
      WindowC.window_set_update(@__pointer, f.pointer)
    end

    # The currently active `TextInput`. If not nil, all keyboard input will be handled by this object.
    #
    # Returns the currently active text input, if any.
    def text_input : Gosu::TextInput?
    end

    # Sets the active `TextInput` to `input`. Set to nil to disable keyboard capture.
    def text_input=(input : Gosu::TextInput?)
    end

    # This method is called after every update and whenever the OS wants the window to repaint itself. Your application's rendering code should go here.
    #
    # See `needs_redraw?`
    def draw
    end

    # This method is called once every `update_interval` milliseconds while the window is being shown. Your application's main logic should go here.
    def update
    end

    # This method is called before `update` if a button is pressed while the window has focus.
    #
    # By default, this will toggle fullscreen mode if the user presses Alt+Enter (Windows,
    # Linux), cmd+F (macOS), or F11 (on all operating systems).
    # To support these shortcuts in your application, make sure to call super in your
    # implementation.
    #
    # `id` the button's platform-defined id.
    #
    # See `button_up`
    # See `Gosu.button_down?`
    def button_down(id : UInt32)
    end

    # This method is called before `update` if a button is released while the window has focus.
    #
    # `id` the button's platform-defined id.
    #
    # See `button_down`
    # See `button_down?`
    def button_up(id : UInt32)
    end

    # This method can be overriden to give the game a chance to opt out of a call to `draw`; however, the operating system can still force a redraw for any reason.
    #
    # Returns whether the window needs to be redrawn.
    #
    # See `#draw`
    def needs_redraw? : Bool
    end

    # This method can be overriden to control the visibility of the system cursor over your window, e.g., for level editors or other situations where introducing a custom cursor or hiding the default one is not desired.
    #
    # Returns whether the system cursor should be shown.
    def needs_cursor? : Bool
    end

    # Called when a file is dropped onto the window.
    #
    # `filename` the filename of the dropped file. When multiple files are dropped, this method will be called several times.
    def drop(filename : String)
    end

    # This method is called whenever the user tries to close the window, e.g. by clicking the [x]
    # button in the window's title bar.
    # If you do not want the window to close immediately, you should override this method and
    # call the `close!` when needed.
    def close : Bool
    end

    # Tells the window to end the current run loop as soon as possible.
    def close!
      WindowC.window_close!(@__pointer)
    end

    # The window's width, in pixels. This only counts the drawable area and does not include any borders or decorations added by the window manager.
    def width : Int32
      WindowC.window_width(@__pointer)
    end

    # The window's height, in pixels. This only counts the drawable area and does not include any borders or decorations added by the window manager.
    def height : Int32
      WindowC.window_height(@__pointer)
    end

    # Sets the window's width to `int`.
    def width=(int : Int32)
      WindowC.window_set_width(@__pointer, int)
    end

    # Sets the window's height to `int`.
    def height=(int : Int32)
      WindowC.window_set_height(@__pointer, int)
    end

    # Returns whether this is a fullscreen window.
    def fullscreen? : Bool
      WindowC.window_fullscreen(@__pointer)
    end

    # Sets whether window is fullscreen to `boolean`.
    def fullscreen=(boolean : Bool)
      WindowC.set_fullscreen(@__pointer, boolean)
    end

    # Whether this window is resizable.
    def resizable? : Bool
      WindowC.window_resizable(@__pointer)
    end

    # Returns the window's caption, usually displayed in the title bar.
    def caption : String
      WindowC.window_caption(@__pointer)
    end

    # Sets the window's caption to `string`.
    def caption=(string : String)
      WindowC.window_set_caption(@__pointer, string)
    end

    # Returns the mouse pointer's window-based X coordinate.
    def mouse_x : Float64
      WindowC.window_mouse_x(@__pointer)
    end

    # Sets the mouse pointer's X coordinate to `double`.
    def mouse_x=(double : Float64)
      WindowC.window_set_mouse_x(@__pointer, double)
    end

    # Returns the mouse pointer's window-based Y coordinate.
    def mouse_y : Float64
      WindowC.window_mouse_y(@__pointer)
    end

    # Sets the mouse pointer's Y coordinate to `double`.
    def mouse_y=(double : Float64)
      WindowC.window_set_mouse_y(@__pointer, double)
    end

    # Sets window's `width`, `height` and whether window is fullscreen.
    def resize(width : Int32, height : Int32, fullscreen : Bool)
      WindowC.window_resize(width, height, fullscreen)
    end

    # Returns the interval between calls to `update`, in milliseconds.
    def update_interval : Float64
    end

    # Sets the interval between calls to `update`.
    def update_interval=(double : Float64)
    end

    # Enters a modal loop where the Window is visible on screen and receives calls to draw, update etc.
    def show
      WindowC.window_show(@__pointer)
    end

    # EXPERIMENTAL - MAY DISAPPEAR WITHOUT WARNING.
    #
    # Performs a single step in the main loop.
    # This can be useful for integrating Gosu with other libraries that have their own main loop, e.g. Ruby/Tk.
    #
    # See: https://www.libgosu.org/cgi-bin/mwf/topic_show.pl?tid=1218
    #
    # If you find a good way to use `tick`, please let us know on the forum and we can make this a part of Gosu's stable interface.
    # Thank you!
    def tick : Bool
      WindowC.window_tick(@__pointer)
    end

    # :nodoc:
    def finalize
      WindowC.destroy_window(@__pointer)
    end
  end
end
