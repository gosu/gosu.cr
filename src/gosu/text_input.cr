module Gosu
  @[Link("gosu")]
  lib TextInputC
    fun create_textinput = Gosu_TextInput_create : UInt8*
    fun destroy_textinput = Gosu_TextInput_destroy(textinput : UInt8*)

    fun caret_pos = Gosu_TextInput_caret_pos(textinput : UInt8*) : UInt32
    fun set_caret_pos = Gosu_TextInput_set_caret_pos(textinput : UInt8*, position : UInt32)
    fun selection_start = Gosu_TextInput_selection_start(textinput : UInt8*) : UInt32
    fun set_caret_pos = Gosu_TextInput_set_caret_pos(textinput : UInt8*, position : UInt32)

    fun text = Gosu_TextInput_text(pointer : UInt8*) : UInt8*
    fun set_text = Gosu_TextInput_set_text(pointer : UInt8*, text : UInt8*)
    fun set_filter = Gosu_TextInput_set_filter(pointer : UInt8*, function : (Void*, UInt8* ->), data : Void*)
    fun set_filter_result = Gosu_TextInput_set_filter_result(pointer : UInt8*, result : UInt8*)

    fun delete_backward = Gosu_TextInput_delete_backward(pointer : UInt8*)
    fun delete_forward = Gosu_TextInput_delete_forward(pointer : UInt8*)
  end

  class TextInput
    @__boxed_filter : Pointer(Void)?

    def initialize
      @__textinput = TextInputC.create_textinput

      proc = ->(text : String){ protected_filter(text) }
      box = Box.box(proc)

      @__boxed_filter = box

      TextInputC.set_filter(pointer, ->(data : Void*, text : UInt8*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(String.new(text))
      }, @__boxed_filter)
    end

    def pointer
      @__textinput
    end

    def caret_pos : UInt32
      TextInputC.caret_pos(pointer)
    end

    def set_caret_pos(position : UInt32)
      TextInputC.set_caret_pos(pointer, position)
    end

    def selection_start : UInt32
      TextInputC.selection_start(pointer)
    end

    def set_selection_start(position : UInt32)
      TextInputC.set_selection_start(pointer, position)
    end

    def text : String
      String.new(TextInputC.text(pointer))
    end

    def text=(text : String)
      TextInputC.set_text(pointer, text)
    end

    def filter(text : String) : String
      text
    end

    def delete_backward
      TextInputC.delete_backward(pointer)
    end

    def delete_forward
      TextInputC.delete_forward(pointer)
    end

    private def protected_filter(text : String)
      string = filter(text)
      TextInputC.set_filter_result(pointer, string)
    end

    def release
      TextInputC.destroy_textinput(pointer)
    end
  end
end
