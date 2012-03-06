class DepartureDateDefault < ActiveRecord::Migration
  def change
    change_column :rides, :duration_in_minutes, :default => 900
    change_column :rides, :flexibility_in_minutes, :default => 900
  end

end
