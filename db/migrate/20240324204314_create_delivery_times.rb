class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.string :name
      t.integer :duration

      t.timestamps
    end
  end
end
