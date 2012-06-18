class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :external_identifier
      t.string :description
      t.string :service
      t.string :severity

      t.timestamps
    end
  end
end
