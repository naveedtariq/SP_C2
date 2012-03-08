# encoding: utf-8

class UserImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
   include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
 # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     "/assets/" + [version_name, "no-image.gif"].compact.join('_')
   end

    # for heroku we need to use tmp folder to get access to uploaded file
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Process files as they are uploaded:
#   process :scale => [200, 300]
#  
#   def scale(width, height)
#
#   end

  # Create different versions of your uploaded files:
   process :resize_to_limit => [50, 50]
   version :thumb do
     process :resize_to_limit => [50, 50]
   end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
   def filename
      random_token = Digest::SHA2.hexdigest("#{Time.now.utc}--#{model.id.to_s}").first(20)
      ivar = "@#{mounted_as}_secure_token"
      token = model.instance_variable_get(ivar)
      token ||= model.instance_variable_set(ivar, random_token)
      "#{token}.#{file.extension}" if original_filename
  end

end
