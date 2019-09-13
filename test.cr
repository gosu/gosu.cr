require "./src/gosu"


window = Gosu::Window._create_window(540, 540, false, 16.6, true)
Gosu::Window._window_set_caption(window, "Hello From Crystal #{Crystal::VERSION}")
Gosu::Window._window_show(window)
Gosu::Window._destroy_window(window)
