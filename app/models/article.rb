class Article < ApplicationRecord
   # title属性を追加
   validates :title, presence: true
end
