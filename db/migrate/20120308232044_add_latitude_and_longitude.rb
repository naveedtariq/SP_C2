class AddLatitudeAndLongitude < ActiveRecord::Migration
  def up
    add_column :request_loggers, :latitude, :float
    add_column :request_loggers, :longitude, :float
    add_column :request_loggers, :ip_address, :string
    remove_column :request_loggers, :request_ip
    
  end

  def down
    remove_column :request_loggers, :latitude
    remove_column :request_loggers, :longitude
    remove_column :request_loggers, :ip_address
    add_column :request_loggers, :request_ip, :string
  end
end
