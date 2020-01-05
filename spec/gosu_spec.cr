require "./spec_helper"
include SpecHelper

describe Gosu do
  it "test drawing primitives" do
    Gosu.responds_to?(:draw_rect).should be_true
    Gosu.responds_to?(:draw_line).should be_true
    Gosu.responds_to?(:draw_triangle).should be_true
    Gosu.responds_to?(:draw_quad).should be_true

    img = Gosu.record(20, 20) do
      Gosu.draw_rect(0, 0, 10, 10, 0xff_ffffff, 0, :default)
      Gosu.draw_line(0, 0, 0xff_ffffff, 10, 10, 0xff_ffffff, 0, :default)
      Gosu.draw_triangle(0, 0, 0xff_ffffff, 10, 10, 0xff_ffffff, 0, 10, 0xff_ffffff, 0, :default)
      Gosu.draw_quad(0, 0, 0xff_ffffff, 10, 10, 0xff_ffffff, 0, 10, 0xff_ffffff, 0, 10, 0xff_ffffff, 0, :default)
    end

    img.class.should eq(Gosu::Image)
  end

  # TODO: Manipulating the current drawing context
  # clip_to  flush  gl  record  rotate  scale  transform  translate

  it "test misc" do
    Gosu.language.should match(/^[a-z]{2}/)

    # TODO: This test can cause trouble if run after other tests, which might have updated Gosu.fps.
    # assert_equal 0, Gosu.fps, "Gosu.fps should be 0 as there is nothing drawn"

    first_call = Gosu.milliseconds
    Gosu.milliseconds.should be_a(UInt64)
    sleep 0.2
    (first_call < Gosu.milliseconds).should be_true

    Gosu.default_font_name.should be_a(String)

    (Gosu.available_height > 0).should be_true
    (Gosu.available_width > 0).should be_true

    (Gosu.screen_height >= Gosu.available_height).should be_true
    (Gosu.screen_width >= Gosu.available_width).should be_true

    Gosu.button_id_to_char(Gosu::KB_G).should eq("g")
    Gosu.char_to_button_id("g").should eq(Gosu::KB_G)
    Gosu.char_to_button_id("G").should eq(Gosu::KB_G)

    Gosu.button_down?(Gosu::KB_A).should be_false
  end

  it "test angle" do
    {
      {0, 0}   => 0.0,
      {1, 0}   => 90.0,
      {1, 1}   => 135.0,
      {0, 1}   => 180.0,
      {-1, 1}  => 225.0,
      {-1, 0}  => 270.0,
      {-1, -1} => 315.0,
      {0, -1}  => 0.0, # 360.0
    }.each do |point, angle|
      Gosu.angle(0, 0, *point).should eq(angle)
    end
  end

  it "test angle diff" do
    {
      [90, 95]  => 5.0,
      [90, 85]  => -5.0,
      [90, 269] => 179.0,
      [90, 271] => -179.0,
    }.each do |(angle1, angle2), delta|
      Gosu.angle_diff(angle1, angle2).should eq(delta)
    end
  end

  it "test offset" do
    {
      [36.86, 5] => [3, -4], # a² + b² = c² | 3² + 4² = 5²
      [0.0, 1]   => [0, -1],
      [90.0, 1]  => [1, 0],
      [180.0, 1] => [0, 1],
      [-90.0, 1] => [-1, 0],
    }.each do |(angle, length), (dx, dy)|
      Gosu.offset_x(angle, length).should be_close(dx, 0.1)
      Gosu.offset_y(angle, length).should be_close(dy, 0.1)
    end
  end

  # TODO: Add more test vectors
  it "test distance" do
    {
      [0, 0, 3, 4]    => 5, # a² + b² = c² | 3² + 4² = 5²
      [-2, -3, -4, 4] => 7.28,
    }.each do |(x1, y1, x2, y2), dist|
      Gosu.distance(x1, y1, x2, y2).should be_close(dist, 0.1)
    end
  end

  it "test random" do
    100.times do
      val = Gosu.random(5, 10)
      val.is_a?(Float).should be_true
      (val >= 5).should be_true
      (val < 10).should be_true
    end
  end

  it "test render" do
    sizes = [25, 50, 500]

    sizes.each do |size|
      assert_output_matches("test_gosu_module/triangle-#{size}", 0.9, {size, size}) do
        Gosu.draw_triangle(0, 0, 0xff_ff0000, size, 0, 0xff_00ff00, size, size, 0xff_0000ff, 0)
      end
    end
  end
end
