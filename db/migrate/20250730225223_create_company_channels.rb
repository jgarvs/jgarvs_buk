class CreateCompanyChannels < ActiveRecord::Migration[7.2]
  def change
    create_table :company_channels do |t|
      t.references :company, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true
      t.boolean :is_activo

      t.timestamps
    end
  end
end
