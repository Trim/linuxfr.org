# encoding: utf-8

class NewsBannerUploader < CarrierWave::Uploader::Base

  NEWS_SIZE_RATIO = 3.5
  NEWS_SMALLER_WIDTH = 350
  DEFAULT_BANNER_URL = "//#{MY_DOMAIN}/images/default-avatar.png"

  include CarrierWave::MiniMagick

  def base_dir
    Rails.root.join("uploads")
  end

  def url
    super.sub(base_dir.to_s, "//#{IMG_DOMAIN}")
  end

  def store_dir
    partition = ("%09d" % model.id).scan(/\d{3}/).reverse.join("/")
    base_dir.join "medias/news/#{partition}"
  end

  def filename
    "banner.#{file.extension}" if original_filename
  end

  def extension_white_list
    %w(jpg jpeg png svg)
  end

  version :large do
    process resize_to_fill: [4*NEWS_SMALLER_WIDTH, 4*NEWS_SMALLER_WIDTH/NEWS_SIZE_RATIO]
  end

  version :medium, from_version: :large do
    process resize_to_fill: [3*NEWS_SMALLER_WIDTH, 3*NEWS_SMALLER_WIDTH/NEWS_SIZE_RATIO]
  end

  version :small, from_version: :medium do
    process resize_to_fill: [2*NEWS_SMALLER_WIDTH, 2*NEWS_SMALLER_WIDTH/NEWS_SIZE_RATIO]
  end

  version :smaller, from_version: :small do
    process resize_to_fill: [NEWS_SMALLER_WIDTH, NEWS_SMALLER_WIDTH/NEWS_SIZE_RATIO]
  end

end
