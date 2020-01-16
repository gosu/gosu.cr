require "./spec_helper"
include SpecHelper

SINGLE_PIXEL = Gosu.render(1, 1) { Gosu.draw_rect(0, 0, 1, 1, Gosu::Color::WHITE) }

describe "Font" do
  it "test_markup_parsing" do
    font = Gosu::Font.new(20)
    # markup_width and text_width will return the same thing, for compatibility, until Gosu 1.0.
    font.markup_width("<b>").should eq(0)
    font.text_width("<b>").should_not eq(0)
  end

  it "test_custom_characters" do
    font = Gosu::Font.new(20)
    font["a"] = SINGLE_PIXEL
    font["b"] = SINGLE_PIXEL
    font["c"] = SINGLE_PIXEL
    # Five square letters will be scaled up to 20px.
    font.text_width("abcba").should eq(100)
  end

  it "test_constructor_args" do
    bold_font = Gosu::Font.new(7, bold: true)
    regular_font = Gosu::Font.new(7, bold: false)

    bold_font.text_width("Afdslkgjd").should_not eq(regular_font.text_width("Afdslkgjd"))
    bold_font.text_width("Afdslkgjd").should eq(regular_font.markup_width("<b>Afdslkgjd</b>"))

    bold_font.markup_width("</b>Afdslkgjd").should eq(regular_font.text_width("Afdslkgjd"))
  end

  it "test_draw_and_draw_rel" do
    font = Gosu::Font.new(10, name: media_path("daniel.otf"))

    assert_output_matches("test_font/draw_markup", 0.98, {200, 100}) do
      # draw this string repeatedly to make up for opacity differences in OpenGL renderers.
      20.times do
        font.draw_markup("Hi! <c=f00>Red.\r\nNew   line! Äöß\n", 5, 5, -6, 2.0, 4.0, 0xff_ff00ff, :add)
      end
    end

    assert_output_matches("test_font/draw_markup_rel", 0.98, {100, 100}) do
      # draw this string repeatedly to make up for opacity differences in OpenGL renderers.
      20.times do
        font.draw_markup_rel("<c=000>I &lt;3 Ruby/Gosu!\n", 50, 50, 5, 0.4, -2)
      end
    end
  end
end
