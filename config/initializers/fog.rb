CarrierWave.configure do |config|
  config.fog_credentials = {
          :provider               => 'AWS',
          :aws_access_key_id      => 'AKIAIG64WP67VSEF3NQA',
          :aws_secret_access_key  => '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',
      }
      config.fog_directory  = 'spc2dev'
      config.fog_public     = true
end