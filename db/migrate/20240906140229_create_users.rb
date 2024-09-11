class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 30
      t.string :last_name, limit: 30
      t.string :email, limit: 80
      t.string :phone, limit: 10
      t.string :password, limit: 100
      t.string :address, limit: 200
      t.string :role, limit: 50

      t.timestamps
    end
  end
end
