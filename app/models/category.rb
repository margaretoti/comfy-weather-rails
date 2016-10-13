class Category < ActiveRecord::Base
  has_many :article_of_clothings

  # has_attached_file :selected_icon
  # has_attached_file :unselected_icon
  #
  # validates_attachment :selected_icon, content_type: { content_type: ['image/png', 'image/svg', 'image/svg+xml'] }
  # validates_attachment :unselected_icon, content_type: { content_type: ['image/png', 'image/svg', 'image/svg+xml'] }

  # validates :name, presence: true
  # validates :selected_icon, presence: true
  # validates :unselected_icon, presence: true

  has_attached_file :selected_icon_1x, presence: true
  has_attached_file :selected_icon_2x, presence: true
  has_attached_file :selected_icon_3x, presence: true

  validates :name, presence: true
  validates_attachment :selected_icon_1x, content_type: { content_type: ['image/png'] }
  validates_attachment :selected_icon_2x, content_type: { content_type: ['image/png'] }
  validates_attachment :selected_icon_3x, content_type: { content_type: ['image/png'] }
end
