class Image < ApplicationRecord
  belongs_to :category

  validates :text, :category_id, presence: true
end
