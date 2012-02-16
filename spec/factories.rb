Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "secret"
  f.password_confirmation "secret"
  f.first_name "test"
  f.last_name "test"
end



