module Facebook
  CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
  APP_ID = CONFIG['app_id']                         # facebook app id which is in facebook.yml
  SECRET = CONFIG['secret_key']                     # facebook app secret key which is in facebook.yml
end

Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    case args.size
      when 0, 1
        raise "application id and/or secret are not specified in the config" unless Facebook::APP_ID && Facebook::SECRET
        initialize_without_default_settings(Facebook::APP_ID.to_s, Facebook::SECRET.to_s, args.first)
      when 2, 3
        initialize_without_default_settings(*args)
    end
  end

  alias_method_chain :initialize, :default_settings
end
