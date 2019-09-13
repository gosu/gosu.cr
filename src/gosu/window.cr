module Gosu
  @[Link("gosu")]
  lib Window
    fun _create_window      = Gosu_Window_create(width : Int32, height : Int32, fullscreen : Bool, update_interval : Float64, resizable : Bool) : UInt8*
    fun _window_show        = Gosu_Window_show(window : Pointer(UInt8))
    fun _window_set_caption = Gosu_Window_set_caption(window : Pointer(UInt8), text : UInt8*)
    fun _destroy_window     = Gosu_Window_destroy(window : Pointer(UInt8))
  end
end