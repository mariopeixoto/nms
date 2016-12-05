class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :generated_pdf_path
      t.text :address
      t.string :name

      t.timestamps
    end
  end
end
