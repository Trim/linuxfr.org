class NewsFigureImageUploader < CarrierWave::Uploader::Base
  NEWS_FIGURE_IMAGE_SMALLER_WIDTH = 300

  NEWS_FIGURE_PPP_RATIO = 3
  NEWS_FIGURE_PPP_HEIGHT = NEWS_FIGURE_IMAGE_SMALLER_WIDTH/NEWS_FIGURE_PPP_RATIO

  NEWS_FIGURE_THUMB_WIDTH = 168
  NEWS_FIGURE_THUMB_HEIGHT = 112

  include CarrierWave::MiniMagick

  # Kind of storage to use for this uploader:
  storage :file

  def base_dir
    Rails.root.join("uploads")
  end

  # Override the directory where uploaded files will be stored.
  def store_dir
    partition = ("%09d" % model.id).scan(/\d{3}/).reverse.join("/")
    base_dir.join "medias/news/#{partition}"
  end

  # Override default URL
  def url(*args)
    super.sub(base_dir.to_s, "//#{IMG_DOMAIN}/")
  end

  # Process files as they are uploaded.
  process :large

  # White list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  def filename
    "news_figure_image.#{file.extension}" if original_filename
  end

  # Move version to the end of the filename
  def full_filename(for_file)
    if parent_name = super(for_file)
      extension = File.extname(parent_name)
      base_name = parent_name.chomp(extension)
      if version_name
        base_name = base_name[version_name.size.succ..-1]
      end
      [base_name, version_name].compact.join("_") + extension
    end
  end

  # Move version to the end of the filename
  def full_original_filename
    parent_name = super
    extension = File.extname(parent_name)
    base_name = parent_name.chomp(extension)
    if version_name
      base_name = base_name[version_name.size.succ..-1]
    end
    [base_name, version_name].compact.join("_") + extension
  end

  # Return value to be used in srcset HTML attribute of img tag
  # according to type of img tag ("normal", "thumb", "ppp")
  def srcset(set_type = "normal")
    if set_type == "thumb"
      - set = "#{url(:thumb)} #{NEWS_FIGURE_THUMB_WIDTH}w,
        #{url(:thumb_ultra)} #{2*NEWS_FIGURE_THUMB_WIDTH}w"
    elsif set_type == "ppp"
      - set = "#{url(:ppp_smaller)} #{NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:ppp_small)} #{2*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:ppp_medium)} #{3*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:ppp_large)} #{4*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:ppp_ultra)} #{10*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w"
    else
      - set = "#{url(:smaller)} #{NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:small)} #{2*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:medium)} #{3*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url()} #{4*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w,
        #{url(:ultra)} #{10*NEWS_FIGURE_IMAGE_SMALLER_WIDTH}w"
    end
    set
  end

  #
  # Versions used by default
  #

  def large()
    resize_to_fit(4*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, -1)
  end

  version :ultra do
    process resize_to_fit(10*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, -1)
  end

  version :medium do
    process resize_to_fit(3*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, -1)
  end

  version :small, from_version: :medium do
    process resize_to_fit(2*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, -1)
  end

  version :smaller, from_version: :small do
    process resize_to_fit(NEWS_FIGURE_IMAGE_SMALLER_WIDTH, -1)
  end

  #
  # Versions used for ppp articles
  #
  version :ppp_ultra do
    process resize_to_fill(10*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, 10*NEWS_FIGURE_PPP_HEIGHT)
  end

  version :ppp_large, from_version: :ppp_ultra do
    process resize_to_fill(4*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, 4*NEWS_FIGURE_PPP_HEIGHT)
  end

  version :ppp_medium, from_version: :ppp_large do
    process resize_to_fill(3*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, 3*NEWS_FIGURE_PPP_HEIGHT)
  end

  version :ppp_small, from_version: :ppp_medium do
    process resize_to_fill(2*NEWS_FIGURE_IMAGE_SMALLER_WIDTH, 2*NEWS_FIGURE_PPP_HEIGHT)
  end

  version :ppp_smaller, from_version: :ppp_small do
    process resize_to_fill(NEWS_FIGURE_IMAGE_SMALLER_WIDTH, NEWS_FIGURE_PPP_HEIGHT)
  end

  #
  # Versions used as thumbnails
  #
  version :thumb_ultra do
    process resize_to_fill(2*NEWS_FIGURE_THUMB_WIDTH, 2*NEWS_FIGURE_THUMB_HEIGHT)
  end

  version :thumb, from_version: :thumb_ultra do
    process resize_to_fill(NEWS_FIGURE_THUMB_WIDTH, NEWS_FIGURE_THUMB_HEIGHT)
  end

end
