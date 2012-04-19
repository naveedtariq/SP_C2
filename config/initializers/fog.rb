CarrierWave.configure do |config|
  config.fog_credentials = {                #Amazon Credentials
          :provider               => 'AWS',
          :aws_access_key_id      => 'AKIAIEYXZ2W34JXX5D7Q',
          :aws_secret_access_key  => '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',
      }
      config.fog_directory  = 'sp404'
      config.fog_public     = true
end