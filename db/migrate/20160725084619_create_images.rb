class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.text :text
      t.references :category, index: true
      t.string :url

      t.timestamps
    end
  end
end
