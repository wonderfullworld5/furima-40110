class AddProfitToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :profit, :integer
  end
end
