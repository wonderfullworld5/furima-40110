class AddCommissionToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :commission, :integer
  end
end
