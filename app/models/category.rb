class Category < ApplicationRecord
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  def random_image
    images.sample.source.url  
  end
end
