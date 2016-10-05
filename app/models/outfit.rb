class Outfit < ActiveRecord::Base
  belongs_to :user

  has_many :outfit_article_of_clothings
  has_many :article_of_clothings, through: :outfit_article_of_clothings

  has_attached_file :photo

  validates_attachment :photo,
  content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'] }

  validates :user, presence: true
  validates :notes, length: { maximum: 250 }
end
