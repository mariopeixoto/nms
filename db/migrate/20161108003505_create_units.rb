class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :number
      t.integer :owner_id, null: false
      t.integer :condominium_id, null: false
      t.string :building

      t.timestamps
    end

    add_foreign_key :units, :owners
    add_foreign_key :units, :condominia
  end
end
