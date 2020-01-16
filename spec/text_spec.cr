require "./spec_helper"

describe "Text" do
  strings = {
    # All of these strings are still horribly broken in Gosu.
    # For now, the value of these tests is that all text is guaranteed to render the same across
    # operating systems.
    "unicode"    => "Grüße vom Test!",
    "whitespace" => "$ ls\n  .\t..\tfoo\r\n  bar\tqux        ",
    "markup"     => "<b>Bold, <u>underlined &amp; <i>italic. <c=4400ff>How <c=0f3>about</c> colors?</c></i></u>&lt;&gt;</b>",
    # All Emoji should be invisible for now.
    # "emoji"      => "Chinese Zodiac: '🐒🐓🐕🐖🐀🐂🐆🐇🐉🐍🐎🐑'[y%12]. ZWJ sequences: 👨🏿‍⚕️ 👨‍👨‍👦",
  }

  option_sets = [
    {font: SpecHelper.media_path("daniel.ttf"), align: :right, width: 139, spacing: 0},
    {font: SpecHelper.media_path("daniel.otf"), align: :center, width: -1, spacing: 10},
  ]

  strings.each do |key, string|
    option_sets.each_with_index do |options, i|
      it "test_text_#{key}_#{i}" do
        Dir.cd(File.join(File.dirname(__FILE__), "test_text")) do
          expected_filename = "text-#{key}-#{i}.png"

          # Prepend <c=f00> to each string because white-on-translucent images are hard
          # to view (at least on macOS).
          image = Gosu::Image.from_markup(
            "<c=ff0000>#{string}", 41,
            font: options[:font], align: options[:align],
            width: options[:width], spacing: options[:spacing]
          )
          image.save actual_from_expected_filename(expected_filename) if ENV["DEBUG"]?
          expected = Gosu::Image.new(expected_filename)

          expected.similar?(image, 0.98).should be_true
        end
      end
    end
  end
end
