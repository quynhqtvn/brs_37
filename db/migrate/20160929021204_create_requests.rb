class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :content
      t.boolean :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
