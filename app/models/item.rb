class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # ActiveHashモデルとの関連付け
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :area
  belongs_to_active_hash :delivery_date, class_name: 'DeliveryDate', foreign_key: :date_id

  # 画像の添付を許可し、必須とするバリデーション
  has_one_attached :image
  validates :image, presence: true
  
  # 商品名が必須であることをバリデーション
  validates :name, presence: true

  # 商品の説明が必須であることをバリデーション
  validates :description, presence: true

  # カテゴリーの情報が必須であることをバリデーション
  validates :category, presence: true, if: :should_validate_category?

  # 商品の状態の情報が必須であることをバリデーション
  validates :condition, presence: true

  # 配送料の負担の情報が必須であることをバリデーション
  validates :postage, presence: true

  # 発送元の地域の情報が必須であることをバリデーション
  validates :area, presence: true

  # 発送までの日数の情報が必須であることをバリデーション
  validates :delivery_date_id, presence: true, if: :should_validate_delivery_date?

  # 価格の情報が必須であることをバリデーション
  validates :price, presence: true

  # 価格が300以上9999999以下であることをバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  # 価格が半角数字であることをバリデーション
  validates :price, format: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください" }

  # 価格に応じた販売手数料と販売利益の計算を行うコールバック
  before_save :calculate_commission_and_profit, if: :price_changed?

  private

  # カテゴリーのバリデーションが必要かどうかを確認するメソッド
  def should_validate_category?
    category.present?
  end

  # 配送日のバリデーションが必要かどうかを確認するメソッド
  def should_validate_delivery_date?
    delivery_date.present?
  end

  # 販売手数料と販売利益の計算を行うメソッド
  def calculate_commission_and_profit
    # 販売手数料の計算
    self.commission = (price * 0.1).floor

    # 販売利益の計算
    self.profit = price - commission
  end
end
