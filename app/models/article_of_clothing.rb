class ArticleOfClothing < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :description, presence: true
end
