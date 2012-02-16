class AddFnameLnameAboutGenderDobPhoneCityTownWorkTitleSchoolDeletedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string

    add_column :users, :last_name, :string

    add_column :users, :about, :text

    add_column :users, :gender, :string

    add_column :users, :dob, :date

    add_column :users, :phone, :integer

    add_column :users, :city, :string

    add_column :users, :town, :string

    add_column :users, :work, :string

    add_column :users, :title, :string

    add_column :users, :school, :string

    add_column :users, :deleted_at, :datetime

  end
end
