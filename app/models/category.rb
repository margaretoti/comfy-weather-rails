class Category < ActiveRecord::Base
  has_many :article_of_clothings

  has_attached_file :selected_icon_1x, presence: true
  has_attached_file :selected_icon_2x, presence: true
  has_attached_file :selected_icon_3x, presence: true

  validates :name, presence: true
  validates_attachment_presence :selected_icon_1x
  validates_attachment_presence :selected_icon_2x
  validates_attachment_presence :selected_icon_3x
  validates_attachment :selected_icon_1x, content_type: { content_type: ['image/png'] }
  validates_attachment :selected_icon_2x, content_type: { content_type: ['image/png'] }
  validates_attachment :selected_icon_3x, content_type: { content_type: ['image/png'] }
end
