class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :created_at2
      t.string :status, limit: 80
      t.integer :total, limit: 15

      t.timestamps
    end
  end
end
