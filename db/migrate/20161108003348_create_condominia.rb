class CreateCondominia < ActiveRecord::Migration
  def change
    create_table :condominia do |t|
      t.string :name, null: false
      t.float :fine_pct, default: 2.0, null: false
      t.float :interest_pct, default: 1.0, null: false
      t.integer :indexation_id, null: false

      t.timestamps
    end

    add_foreign_key :condominia, :indexations
  end
end
