class BoardImageUploader < CarrierWave::Uploader::Base
 
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #デフォルト画像の設定
  def default_url
    "board_placeholder"   # デフォルト画像に設定したい画像名を記入
  end

  #アップロードファイルの指定
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  #def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [versionname, "default.png"].compact.join(''))

  #   "/images/fallback/" + [versionname, "default.png"].compact.join('')


  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #  process resize_to_fit: [300, 200]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  end