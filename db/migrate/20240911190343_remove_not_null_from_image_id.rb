class RemoveNotNullFromImageId < ActiveRecord::Migration[7.1]
  def change
    change_column_null :products, :image_id, true
  end
end
