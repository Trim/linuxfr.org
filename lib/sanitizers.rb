# encoding: utf-8


class Sanitizer
  # Normalize with NFKC Unicode normalization algorithm
  # This one of the recommended way to resolve visual spoofing attacks:
  # https://unicode.org/reports/tr36/tr36-8.html#Visual_Spoofing_Recommendations
  def self.visual_normalize(text)
    text.unicode_normalize(text, :nfkc)
  end
end
