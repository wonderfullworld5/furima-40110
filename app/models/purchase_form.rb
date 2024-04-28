class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :area_id, :city, :street, :building, :phone

  # バリデーションを追加
  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: "はハイフンを含む7桁で入力してください" }
    validates :area_id, numericality: { only_integer: true, greater_than: 0, message: "を選択してください" }
    validates :city
    validates :street
    validates :phone, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の数字で入力してください" }
  end


  # 保存処理
  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      record = Record.create!(user_id: user_id, item_id: item_id)
      Ship.create!(record_id: record.id, postcode: postcode, area_id: area_id, city: city, street: street, building: building, phone: phone)
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end

