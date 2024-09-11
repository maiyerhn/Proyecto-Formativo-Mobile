class AddImageIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :image, foreign_key: { to_table: :active_storage_blobs }, null: true
  end
end
