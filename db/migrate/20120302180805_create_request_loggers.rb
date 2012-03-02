class CreateRequestLoggers < ActiveRecord::Migration
  def change
    create_table :request_loggers do |t|
      t.text :params
      t.string :user_agent
      t.string :request_ip
      t.timestamps
    end
  end
end
