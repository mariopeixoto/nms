class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.integer :unit_id, null: false
      t.integer :debt_type_id, null: false
      t.date :due_date, null: false
      t.string :description
      t.float :original_amount, null: false
      t.boolean :paid, null: false, default: false
      t.integer :notice_id

      t.timestamps
    end

    add_foreign_key :debts, :units
    add_foreign_key :debts, :debt_types
    add_foreign_key :debts, :notices
  end
end
