class CreateIndexationValues < ActiveRecord::Migration
  def change
    create_table :indexation_values, id: false do |t|
      t.integer :indexation_id
      t.date :month
      t.float :value
    end
    execute "ALTER TABLE indexation_values ADD PRIMARY KEY (indexation_id,month);"

    add_foreign_key :indexation_values, :indexations
  end
end
