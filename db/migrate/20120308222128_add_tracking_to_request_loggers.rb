class AddTrackingToRequestLoggers < ActiveRecord::Migration
  def self.up
    add_column :request_loggers, :request_url, :string
    add_column :request_loggers, :referer, :string
    add_column :request_loggers, :cookie_string, :text
  end
  def self.down
    remove_column :request_loggers, :request_url
    remove_column :request_loggers, :referer
    remove_column :request_loggers, :cookie_string
  end
end
