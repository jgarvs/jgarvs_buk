class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :sender
      t.string :title
      t.string :body
      t.boolean :urgent
      t.datetime :processed_at
      t.integer :company_configuration_reference
      # Only works on Postgress
      t.string :recipients, array: true, default: [], null: false

      t.timestamps
    end
  end
end
