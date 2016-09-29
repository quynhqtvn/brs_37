class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :alias
      t.text :description
      t.datetime :publish_date
      t.string :author
      t.integer :num_pages
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
