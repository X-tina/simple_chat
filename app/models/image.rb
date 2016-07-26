class Image < ApplicationRecord
  belongs_to :category

  has_attached_file :source,
                    styles: { original: "300x300>" },
                    default_url: ""
  validates_attachment_content_type :source, content_type: /\Aimage\/.*\Z/
end
