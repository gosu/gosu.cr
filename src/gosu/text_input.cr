module Gosu
  @[Link("gosu-ffi")]
  lib TextInputC
    fun create_textinput = Gosu_TextInput_create : UInt8*
    fun destroy_textinput = Gosu_TextInput_destroy(textinput : UInt8*)

    fun caret_pos = Gosu_TextInput_caret_pos(textinput : UInt8*) : UInt32
    fun set_caret_pos = Gosu_TextInput_set_caret_pos(textinput : UInt8*, position : UInt32)
    fun selection_start = Gosu_TextInput_selection_start(textinput : UInt8*) : UInt32
    fun set_selection_start = Gosu_TextInput_set_selection_start(textinput : UInt8*, position : UInt32)

    fun text = Gosu_TextInput_text(pointer : UInt8*) : UInt8*
    fun set_text = Gosu_TextInput_set_text(pointer : UInt8*, text : UInt8*)
    fun insert_text = Gosu_TextInput_insert_text(pointer : UInt8*, text : UInt8*)
    fun set_filter = Gosu_TextInput_set_filter(pointer : UInt8*, function : (Void*, UInt8* ->), data : Void*)
    fun set_filter_result = Gosu_TextInput_set_filter_result(pointer : UInt8*, result : UInt8*)

    fun delete_backward = Gosu_TextInput_delete_backward(pointer : UInt8*)
    fun delete_forward = Gosu_TextInput_delete_forward(pointer : UInt8*)
  end

  #
  # A TextInput is an invisible object that handles input using the operating system's input manager.
  #
  # At its most basic, you only need to set `Gosu::Window#text_input` to an instance of this class. The TextInput will then handle all keyboard input until `Gosu::Window#text_input` is set to `nil`. Any text the user has typed is available through `text`.
  #
  # This class is purely back-end and does not come with a GUI; drawing the input field is up to you, the programmer. The best way to do that is left completely open. TextInput only aims to provide a foundation for you to build your own GUI.
  #
  # see `Gosu::Window#text_input`
  #
  # see file: examples/TextInput.cr
  class TextInput
    @__boxed_filter : Pointer(Void)?

    def initialize
      @__textinput = TextInputC.create_textinput

      proc = ->(text : String) { protected_filter(text) }
      box = Box.box(proc)

      @__boxed_filter = box

      TextInputC.set_filter(pointer, ->(data : Void*, text : UInt8*) {
        callback = Box(typeof(proc)).unbox(data)
        callback.call(String.new(text))
      }, @__boxed_filter.not_nil!)
    end

    # :nodoc:
    def pointer
      @__textinput
    end

    # The position of the editing caret.
    def caret_pos : UInt32
      TextInputC.caret_pos(pointer)
    end

    # Sets the position of the editing caret to `position`.
    def caret_pos=(position : UInt32 | Int32)
      TextInputC.set_caret_pos(pointer, position.to_u32)
    end

    # The starting position of the currently selected text.
    def selection_start : UInt32
      TextInputC.selection_start(pointer)
    end

    # Sets the starting position of the currently selected text to `position`.
    def selection_start=(position : UInt32 | Int32)
      TextInputC.set_selection_start(pointer, position.to_u32)
    end

    # The text that the user has typed.
    def text : String
      String.new(TextInputC.text(pointer))
    end

    # Replaces `TextInput` text with `text`.
    def text=(text : String)
      TextInputC.set_text(pointer, text)
    end

    #
    # Replaces the current selection (if any) and inserts the given string at the current caret position.
    # The filter method will not be applied before appending the string.
    def insert_text(text : String)
      TextInputC.insert_text(pointer, text)
    end

    #
    # This method is an overridable filter that is applied to all newly entered text. This allows for restricting input characters or format, automatic macro or abbreviation expansion and so on.
    #
    # The return value of this method will be inserted at the current caret position.
    #
    # The default implementation returns its argument unchanged.
    #
    # Example: Forcing input to all uppercase, alphanumeric characters.
    # ```
    # input = TextInput.new
    #
    # def input.filter(text_in)
    #   text_in.upcase.gsub(/[^A-Z0-9]/, "")
    # end
    # ```
    def filter(text : String) : String
      text
    end

    # Deletes the current selection, if any, or the previous character.
    def delete_backward
      TextInputC.delete_backward(pointer)
    end

    # Deletes the current selection, if any, or the next character.
    def delete_forward
      TextInputC.delete_forward(pointer)
    end

    private def protected_filter(text : String)
      string = filter(text)
      TextInputC.set_filter_result(pointer, string)
    end

    # :nodoc:
    def release
      TextInputC.destroy_textinput(pointer)
    end
  end
end
