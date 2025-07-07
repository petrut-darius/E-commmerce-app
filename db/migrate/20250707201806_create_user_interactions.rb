class CreateUserInteractions < ActiveRecord::Migration[8.0]
  def change
    create_table :user_interactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :event_type

      t.timestamps
    end
  end
end
