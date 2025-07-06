class AddComment < ActiveRecord::Migration[8.0]
  def change
      create_table :comments do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.string :title, null: false
      t.string :body, null: false


      t.timestamps
    end
  end
end
