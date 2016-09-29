class Category < ActiveRecord::Base
  has_many :article_of_clothings

  has_attached_file :icon

  validates_attachment :icon, content_type: { content_type: ['image/png'] }

  validates :name, presence: true
  validates :icon, presence: true
end
