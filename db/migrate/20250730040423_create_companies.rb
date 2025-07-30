class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :key
      t.string :name

      t.timestamps
    end
    add_index :companies, :key, unique: true
  end
end
