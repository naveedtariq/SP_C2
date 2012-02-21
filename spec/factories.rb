Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "secret"
  f.password_confirmation "secret"
  f.first_name "test"
  f.last_name "test"
  f.photo_file_name "/home/devsinc/Desktop/apple-logo.jpg"
end
Factory.define :ride do |f|
  f.sequence(:to_city) { |n| "foo#{n}" }
  f.sequence(:from_city) { |n| "foo#{n}" }
  f.available_seats 3
  f.price_per_seat 3
  f.departure_datetime Time.now
  f.arrival_datetime Time.now
  f.ride_type "Sudon"
end



