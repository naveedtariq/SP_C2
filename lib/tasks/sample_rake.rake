# -*- coding: utf-8 -*-

# see
# http://rubydoc.info/github/stympy/faker/master/frames
# and
# http://faker.rubyforge.org/rdoc/
# for documentation
require 'csv'    
namespace :db do
  desc 'Populates database with generated sample data'
  
  task :populate => :environment do 
    puts "started dumping"
    csv_text = File.read("#{Rails.root}/spec/data/user.csv")
    puts "dumping users"
    csv = CSV.parse(csv_text, :headers => true)

    male_images = []
    female_images = []
    path = "#{Rails.root}/spec/data/male/"
    Dir::foreach(path) { |f| male_images << File.open(path + "#{f}") if f[f.size-3..f.size-1] === "jpg" }
    path = "#{Rails.root}/spec/data/female/"
    Dir::foreach(path) { |f| female_images << File.open(path + "#{f}") if f[f.size-3..f.size-1] === "jpg" }
   

    csv.each_with_index do |row, index|
      row = row.to_hash.with_indifferent_access
      u = User.new(row.to_hash.symbolize_keys)
      if u.gender && u.gender.downcase == "male"
        puts "in males directory"
        u.user_image = male_images[(SecureRandom.random_number * male_images.size).to_i]
      else
        puts "in females directory"
        u.user_image = female_images[(SecureRandom.random_number * female_images.size).to_i]
      end
      puts "(#{index}) name ---> #{u.full_name}, gender --> #{u.gender}"
      u.save!
    end


    puts "dumping locations"

    csv_text = File.read("#{Rails.root}/spec/data/location.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      location = Location.create!(row.to_hash.symbolize_keys)
      puts "location --> #{location.name}"

    end
    csv_text = File.read("#{Rails.root}/spec/data/ride.csv")
    csv = CSV.parse(csv_text, :headers => true)
    users = User.all
    added_users = []
    puts "dumping rides"
    csv.each_with_index  do |row, index|
      row = row.to_hash.with_indifferent_access
      ride = Ride.new(row.to_hash.symbolize_keys)
      user = ((users.delete_at(rand(users.size-1)+1)) || User.last)
      ride.save!
      puts "(#{index}) ride departure date --> #{ride.departure_date}"

      ride.users << user
      unless added_users.blank?
        if(index % 3) == 0
          added_user = added_users.delete_at(rand(added_users.size-1)+1)
          ride.ride_participants.create!(:role => ROLES_FOR_RIDES[:pending], :user_id => (added_user.id), :number_of_seats => 1, :phone => "234234", :mode_of_communications => "phone" )
        end
      end
      added_users << user
      if users.blank?
        users = User.all
        added_users = []
      end
    end
  end
end
