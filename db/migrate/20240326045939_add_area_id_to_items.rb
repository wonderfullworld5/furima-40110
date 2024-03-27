class AddAreaIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :area_id, :integer
  end
end
