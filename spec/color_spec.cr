require "./spec_helper"

describe Gosu::Color do
  it "test_predefined_colors" do
    Gosu::Color::NONE.should be_a(Gosu::Color)
    Gosu::Color::BLACK.should be_a(Gosu::Color)
    Gosu::Color::GRAY.should be_a(Gosu::Color)
    Gosu::Color::WHITE.should be_a(Gosu::Color)
    Gosu::Color::AQUA.should be_a(Gosu::Color)
    Gosu::Color::RED.should be_a(Gosu::Color)
    Gosu::Color::GREEN.should be_a(Gosu::Color)
    Gosu::Color::BLUE.should be_a(Gosu::Color)
    Gosu::Color::YELLOW.should be_a(Gosu::Color)
    Gosu::Color::FUCHSIA.should be_a(Gosu::Color)
    Gosu::Color::CYAN.should be_a(Gosu::Color)
  end


  it "test_color_creation" do
    # ARGB
    Gosu::Color::CYAN.should eq(Gosu::Color.new(0xff_00ffff))
    Gosu::Color::RED.should eq(Gosu::Color.new( 0xff, 0xff, 0x00, 0x00))
    Gosu::Color::GREEN.should eq(Gosu::Color.argb(0xff, 0x00, 0xff, 0x00))
    Gosu::Color::BLUE.should eq(Gosu::Color.rgba(0x00, 0x00, 0xff, 0xff))

    # # (A)HSV
    Gosu::Color::FUCHSIA.should eq(Gosu::Color.from_hsv(300, 1.0, 1.0))
    Gosu::Color::YELLOW.should eq( Gosu::Color.from_ahsv(255, 60, 1.0, 1.0))
  end


  it "test_color_atttributes_and_types" do
    color = Gosu::Color.new(255, 255, 255, 255)

    color.responds_to?(:alpha).should be_true
    color.responds_to?(:red).should be_true
    color.responds_to?(:green).should be_true
    color.responds_to?(:blue).should be_true
    color.alpha.should be_a(UInt8)
    color.red.should be_a(UInt8)
    color.green.should be_a(UInt8)
    color.blue.should be_a(UInt8)

    color.responds_to?(:hue).should be_true
    color.responds_to?(:saturation).should be_true
    color.responds_to?(:value).should be_true
    color.hue.should be_a(Float64)
    color.saturation.should be_a(Float64)
    color.value.should be_a(Float64)
  end


  it "test_color_attribute_ranges" do
    # alpha, red, green, blue are clamped to 0..255.
    Gosu::Color::WHITE.should eq(Gosu::Color.new(300, 300, 300, 300))
    Gosu::Color::NONE.should eq( Gosu::Color.new(-50, -50, -50, -50))

    # hue wraps(!) at 360, so 361 is the same as 1.
    Gosu::Color.from_ahsv(100, 1, 1.0, 1.0).should eq(Gosu::Color.from_ahsv(100, 361, 1.0, 1.0))

    # saturation and value are clamped to 0.0..1.0 (since commit 01120e92f7a3).
    Gosu::Color.from_ahsv(100, 1, 1.0, 1.0).should eq(Gosu::Color.from_ahsv(100, 361,  2.0,  2.0))
    Gosu::Color.from_ahsv(100, 1, 0.0, 0.0).should eq(Gosu::Color.from_ahsv(100, 361, -1.0, -1.0))
  end


  it "test_dup_and_gl" do
    Gosu::Color::BLACK.object_id.should_not eq(Gosu::Color::BLACK.dup.object_id)
    0xff00ff00.should eq(Gosu::Color::GREEN.gl)
  end


  # introduced by #316, requested by #333 (@shawn42)
  # this is not documented in rdoc/gosu.rb
  it "test_alias" do
    Gosu::Color::AQUA.eql?(Gosu::Color::CYAN).should be_true
    Gosu::Color::AQUA.hash.should eq(Gosu::Color::AQUA.gl)
  end
end