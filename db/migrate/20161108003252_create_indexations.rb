class CreateIndexations < ActiveRecord::Migration
  def change
    create_table :indexations do |t|
      t.string :name
      t.integer :tpa_id, null: false

      t.timestamps
    end
  end
end
