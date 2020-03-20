require "spec"
require "../src/gosu.cr"

class Gosu::Image
  # Gosu does not implement this method by default because it is very inefficient.
  # However, it is useful for testing, and makes it easy to use assert_equal on images.
  def ==(other)
    if other.is_a? Gosu::Image
      (to_blob rescue object_id) == (other.to_blob rescue other.object_id)
    else
      false
    end
  end

  # Checks if two images are similar on a really basic level (check the difference of each channel)
  def similar?(img, threshold)
    return true if self == img
    return false unless img.is_a?(Gosu::Image)
    return false if self.width != img.width || self.height != img.height

    blob = img.to_blob.bytes
    differences = [] of Float64

    self.to_blob.each_byte.with_index do |byte, idx|
      delta = (byte.to_i - blob[idx].to_i).abs
      differences << (delta / 255.0) if delta > 0
    end

    # If the average color difference is only subtle even on "large" parts of the image its still ok (e.g. differently rendered color gradients) OR
    # if the color difference is huge but on only a few pixels its ok too (e.g. a diagonal line may be off a few pixels)
    result = (1 - (differences.sum / differences.size) >= threshold) || (1 - (differences.size / blob.size.to_f) >= threshold)
    return result
  end
end

module SpecHelper
  def self.media_path(fname = "")
    File.join(File.dirname(__FILE__), "media", fname)
  end

  def media_path(fname = "")
    SpecHelper.media_path(fname)
  end

  def actual_from_expected_filename(expected)
    actual_basename = File.basename(expected, ".png") + ".actual.png"
    File.join(File.dirname(expected), actual_basename)
  end

  def assert_image_matches(expected, actual_image, threshold)
    expected_filename = File.expand_path("#{expected}.png", File.dirname(__FILE__))
    actual_filename = actual_from_expected_filename(expected_filename)

    unless actual_image.similar?(Gosu::Image.new(expected_filename), threshold)
      # When a comparison fails, save the "actual" image next to the expected one.
      actual_image.save actual_filename
      raise "Image should look similar to #{expected_filename}"
    end
    # Since the comparison succeeded, we can clean up the last "actual" image (if any).
    File.delete actual_filename if File.exists?(actual_filename)
  end

  def assert_output_matches(expected, threshold, size, &block)
    expected = File.expand_path("#{expected}.png", File.dirname(__FILE__))

    actual_image = Gosu.render(*size) { block.call }

    actual_image.save(actual_from_expected_filename(expected)) if ENV["DEBUG"]?

    actual_image.similar?(Gosu::Image.new(expected), threshold).should be_true
  end
end
