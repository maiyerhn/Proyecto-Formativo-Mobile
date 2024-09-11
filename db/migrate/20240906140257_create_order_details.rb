class CreateOrderDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, limit: 10
      t.integer :total, limit: 15

      t.timestamps
    end
  end
end
