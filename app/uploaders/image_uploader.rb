class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick
  process :resize_to_limit => [1280, 1024]
  process :convert => 'jpg'
  
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
  
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end
  
  version :thumb do
    process :resize_to_fill => [300, 300]
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
