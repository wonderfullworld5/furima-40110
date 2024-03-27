class AddDurationToDeliveryDates < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_dates, :duration, :integer
  end
end
