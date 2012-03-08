class RequestLogger < ActiveRecord::Base
  geocoded_by :ip_address
  after_validation :geocode
end
