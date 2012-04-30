Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "secret"
  f.password_confirmation "secret"
  f.first_name "test"
  f.last_name "test"
#  f.photo_file_name "/home/devsinc/Desktop/apple-logo.jpg"
end
Factory.define :location do |f|
  f.sequence(:name) { |n| "foo#{n}" }
end
Factory.define :ride do |f|
  l = Factory(:location)
  f.to_location_id l.id
  l = Factory(:location)
  f.from_location_id l.id
  f.available_seats 3
  f.total_price 3
  f.departure_date RequestLogger.sp_clock_date
  f.departure_time RequestLogger.sp_clock_time
  f.duration_in_minutes 15
  f.ride_type "Sudon"
end

