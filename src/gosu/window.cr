module Gosu
  @[Link("gosu-ffi")]
  lib WindowC
    fun create_window = Gosu_Window_create(width : Int32, height : Int32, window_flags : UInt32, update_interval : Float64) : UInt8*
    fun window_show = Gosu_Window_show(window : UInt8*)
    fun window_tick = Gosu_Window_tick(window : UInt8*) : Bool
    fun window_caption = Gosu_Window_caption(window : UInt8*) : UInt8*
    fun window_set_caption = Gosu_Window_set_caption(window : UInt8*, text : UInt8*)

    fun window_text_input = Gosu_Window_text_input(window : UInt8*) : UInt8*
    fun window_set_text_input = Gosu_Window_set_text_input(window : UInt8*, input : UInt8*)

    # Callbacks
    fun window_set_draw = Gosu_Window_set_draw(window : UInt8*, function : Void* ->, data : Void*)
    fun window_set_update = Gosu_Window_set_update(window : UInt8*, function : Void* ->, data : Void*)
    fun window_set_button_down = Gosu_Window_set_button_down(window : UInt8*, function : (Void*, UInt32 ->), data : Void*)
    fun window_set_button_up = Gosu_Window_set_button_up(window : UInt8*, function : (Void*, UInt32 ->), data : Void*)
    fun window_set_drop = Gosu_Window_set_drop(window : UInt8*, function : (Void*, UInt8* ->), data : Void*)
    fun window_set_needs_redraw = Gosu_Window_set_needs_redraw(window : UInt8*, function : Void* ->, data : Void*)
    fun window_set_needs_cursor = Gosu_Window_set_needs_cursor(window : UInt8*, function : Void* ->, data : Void*)
    fun window_set_close = Gosu_Window_set_close(window : UInt8*, function : Void* ->, data : Void*)
    fun window_set_gamepad_connected = Gosu_Window_set_gamepad_connected(window : UInt8*, function : (Void*, UInt32 ->), data : Void*)
    fun window_set_gamepad_disconnected = Gosu_Window_set_gamepad_disconnected(window : UInt8*, function : (Void*, UInt32 ->), data : Void*)

    fun window_button_down = Gosu_Window_default_button_down(window : UInt8*, id : UInt32)

    # Dimensions
    fun window_width = Gosu_Window_width(window : UInt8*) : Int32
    fun window_height = Gosu_Window_height(window : UInt8*) : Int32
    fun window_set_width = Gosu_Window_set_width(window : UInt8*, width : Int32)
    fun window_set_height = Gosu_Window_set_height(window : UInt8*, height : Int32)
    fun window_fullscreen = Gosu_Window_fullscreen(window : UInt8*) : Bool
    fun window_set_fullscreen = Gosu_Window_set_fullscreen(window : UInt8*, fullscreen : Bool)

    fun window_update_interval = Gosu_Window_update_interval(window : UInt8*)
    fun window_set_update_interval = Gosu_Window_set_update_interval(window : UInt8*, interval : Float64)

    # Mouse
    fun window_mouse_x = Gosu_Window_mouse_x(window : UInt8*) : Float64
    fun window_mouse_y = Gosu_Window_mouse_y(window : UInt8*) : Float64
    fun window_set_mouse_x = Gosu_Window_set_mouse_x(window : UInt8*, x : Float64)
    fun window_set_mouse_y = Gosu_Window_set_mouse_y(window : UInt8*, y : Float64)

    fun window_close! = Gosu_Window_close_immediately(window : UInt8*) : Bool

    fun destroy_window = Gosu_Window_destroy(window : UInt8*)
  end

  class Window
    @boxed_draw : Pointer(Void)?
    @boxed_update : Pointer(Void)?
    @boxed_button_down : Pointer(Void)?
    @boxed_button_up : Pointer(Void)?
    @boxed_drop : Pointer(Void)?
    @boxed_needs_redraw : Pointer(Void)?
    @boxed_needs_cursor : Pointer(Void)?
    @boxed_close : Pointer(Void)?
    @boxed_gamepad_connected : Pointer(Void)?
    @boxed_gamepad_disconnected : Pointer(Void)?

    @text_input : Gosu::TextInput?

    def initialize(width, height, fullscreen = false, update_interval = 16.66666667, resizable = false, borderless = false)
      @__pointer = WindowC.create_window(width, height, Gosu.window_flags(fullscreen, resizable, borderless), update_interval)

      _set_update_callback
      _set_draw_callback
      _set_button_down_callback
      _set_button_up_callback
      _set_drop_callback
      _set_needs_redraw_callback
      _set_needs_cursor_callback
      _set_close_callback
      _set_gamepad_connected_callback
      _set_gamepad_disconnected_callback
    end

    # The currently active `TextInput`. If not nil, all keyboard input will be handled by this object.
    #
    # Returns the currently active text input, if any.
    def text_input : Gosu::TextInput?
      @text_input ? @text_input : nil
    end

    # Sets the active `TextInput` to `input`. Set to nil to disable keyboard capture.
    def text_input=(input : Gosu::TextInput?)
      if input
        @text_input = input
        WindowC.window_set_text_input(@__pointer, input.pointer)
      else
        @text_input = nil
        WindowC.window_set_text_input(@__pointer, Pointer(UInt8).null)
      end
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
      WindowC.window_button_down(@__pointer, id)
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
      true
    end

    # This method can be overriden to control the visibility of the system cursor over your window, e.g., for level editors or other situations where introducing a custom cursor or hiding the default one is not desired.
    #
    # Returns whether the system cursor should be shown.
    def needs_cursor? : Bool
      false
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
      close!
    end

    # Tells the window to end the current run loop as soon as possible.
    def close! : Bool
      WindowC.window_close!(@__pointer)
    end

    def gamepad_connected(id : UInt32)
    end

    def gamepad_disconnected(id : UInt32)
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
      String.new(WindowC.window_caption(@__pointer))
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
      WindowC.window_update_interval(@__pointer)
    end

    # Sets the interval between calls to `update`.
    def update_interval=(double : Float64)
      WindowC.window_set_update_interval(@__pointer, double)
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
    # **HORRIBLE** duplication, more research needed.
    def _set_update_callback
      proc = ->{ update }
      box = Box.box(proc)

      @boxed_update = box

      WindowC.window_set_update(@__pointer, ->(data : Void*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call
      }, @boxed_update)
    end

    # :nodoc:
    def _set_draw_callback
      proc = ->{ draw }
      box = Box.box(proc)

      @boxed_draw = box

      WindowC.window_set_draw(@__pointer, ->(data : Void*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call
      }, @boxed_draw)
    end

    # :nodoc:
    def _set_button_down_callback
      proc = ->(id : UInt32) { button_down(id) }
      box = Box.box(proc)

      @boxed_button_down = box

      WindowC.window_set_button_down(@__pointer, ->(data : Void*, id : UInt32) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(id)
      }, @boxed_button_down)
    end

    # :nodoc:
    def _set_button_up_callback
      proc = ->(id : UInt32) { button_up(id) }
      box = Box.box(proc)

      @boxed_button_up = box

      WindowC.window_set_button_up(@__pointer, ->(data : Void*, id : UInt32) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(id)
      }, @boxed_button_up)
    end

    # :nodoc:
    def _set_drop_callback
      proc = ->(filename : String) { drop(filename) }
      box = Box.box(proc)

      @boxed_drop = box

      WindowC.window_set_drop(@__pointer, ->(data : Void*, filename : UInt8*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(String.new(filename))
      }, @boxed_drop)
    end

    # :nodoc:
    def _set_needs_redraw_callback
      proc = ->{ needs_redraw? }
      box = Box.box(proc)

      @boxed_needs_redraw = box

      WindowC.window_set_needs_redraw(@__pointer, ->(data : Void*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call
      }, @boxed_needs_redraw)
    end

    # :nodoc:
    def _set_needs_cursor_callback
      proc = ->{ needs_cursor? }
      box = Box.box(proc)

      @boxed_needs_cursor = box

      WindowC.window_set_needs_cursor(@__pointer, ->(data : Void*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call
      }, @boxed_needs_cursor)
    end

    # :nodoc:
    def _set_close_callback
      proc = ->{ close }
      box = Box.box(proc)

      @boxed_close = box

      WindowC.window_set_close(@__pointer, ->(data : Void*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call
      }, @boxed_close)
    end

    # :nodoc:
    def _set_gamepad_connected_callback
      proc = ->(id : UInt32) { gamepad_connected(id) }
      box = Box.box(proc)

      @boxed_gamepad_connected = box

      WindowC.window_set_gamepad_connected(@__pointer, ->(data : Void*, id : UInt32) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(id)
      }, @boxed_gamepad_connected)
    end

    # :nodoc:
    def _set_gamepad_disconnected_callback
      proc = ->(id : UInt32) { gamepad_disconnected(id) }
      box = Box.box(proc)

      @boxed_gamepad_disconnected = box

      WindowC.window_set_gamepad_disconnected(@__pointer, ->(data : Void*, id : UInt32) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(id)
      }, @boxed_gamepad_disconnected)
    end

    # :nodoc:
    def finalize
      WindowC.destroy_window(@__pointer)
    end
  end
end
