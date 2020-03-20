require "./spec_helper"
include SpecHelper

private def circle_image(radius)
  size = radius * 2 + 1
  rgba = Bytes.new(size * size * 4, 0)

  # Opaque blue - as an  -RGBA st -ring (0 -x0000ffff).
  inside = [0x00_u8, 0x00_u8, 0xff_u8, 0xff_u8]
  # Transparent  -blue as - an RGB -A strin -g (0x0000ff00).
  outside = [0x00_u8, 0xff_u8, 0xff_u8, 0x00_u8]

  # This creates a binary string that contains a circle, thanks to the
  # Pythagorean theorem.
  # Note that the returned size is (radius * 2 + 1), not (radius * 2).
  blob = [] of Array(UInt8)

  size.times do |y|
    size.times do |x|
      if Gosu.distance(radius, radius, x, y).round <= radius
        blob << inside
      else
        blob << outside
      end
    end
  end

  blob = blob.flatten
  blob.each_with_index do |byte, i|
    rgba[i] = byte
  end

  Gosu::Image.from_blob(size, size, rgba)
end

# TODO: check for a more efficient method?
private def rect_image(w, h)
  size = w * h * 4
  rgba = Bytes.new(size)

  red = [0xff_u8, 0x00_u8, 0x00_u8, 0xff_u8]
  white = [0xff_u8, 0xff_u8, 0xff_u8, 0xff_u8]

  blob = red * w +
         (red + white * (w - 2) + red) * (h - 2) +
         red * w

  blob.each_with_index do |byte, i|
    rgba[i] = byte
  end

  Gosu::Image.from_blob(w, h, rgba)
end

describe "Image" do
  it "test_image_from_blob" do
    assert_image_matches "test_image/from_blob", circle_image(70), 1.00
  end

  # This uses large images so it implicitly tests the whole stack:
  # - Gosu::LargeImageData::insert
  # - Gosu::TexChunk::insert
  # - Gosu::Bitmap::insert
  it "test_image_insert" do
    canvas = Gosu::Image.from_blob(3000, 2000)
    stamp = rect_image(1337, 1337)

    8.times do |i|
      canvas.insert stamp, i * 300, i * 123
    end

    assert_image_matches "test_image/insert", canvas, 0.99
  end
end
