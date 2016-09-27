class Outfit < ActiveRecord::Base
  belongs_to :user

  has_attached_file :photo

  validates_attachment :photo, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'] }

  validates :rating, presence: true
  validates :notes, length: { maximum: 250 }
end
