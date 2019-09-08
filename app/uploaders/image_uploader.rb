class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick
  process :resize_to_limit => [640, 480]
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

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
