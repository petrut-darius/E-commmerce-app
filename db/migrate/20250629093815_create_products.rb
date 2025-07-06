class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ""
      t.string :sku, null: false, default: ""
      t.integer :sex, null: false, default: 0
      t.string :size, null: false, default: ""
      t.string :color, null: false, default: ""

      t.timestamps
    end

    add_index :products, :sku, unique: true
  end
end
