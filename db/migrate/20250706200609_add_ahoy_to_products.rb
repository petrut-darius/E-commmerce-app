class AddAhoyToProducts < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :ahoy_visit
  end
end
