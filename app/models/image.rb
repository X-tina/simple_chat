class Image < ApplicationRecord
  belongs_to :category

  has_attached_file :source,
                    styles: { original: "300x300>" },
                    default_url: "",
                    storage: :s3,
                    s3_credentials: S3_CREDENTIALS
  validates_attachment_content_type :source, content_type: /\Aimage\/.*\Z/
  validates :text, presence: true
end
