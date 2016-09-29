class CreateBookUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :book_users do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status
      t.boolean :favorite

      t.timestamps
    end
  end
end
