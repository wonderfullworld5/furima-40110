class AddDateIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :date_id, :integer
  end
end
