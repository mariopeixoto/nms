class CreateDebtTypes < ActiveRecord::Migration
  def change
    create_table :debt_types do |t|
      t.string :debt_type

      t.timestamps
    end
  end
end
