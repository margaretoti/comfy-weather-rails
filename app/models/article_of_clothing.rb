class ArticleOfClothing < ActiveRecord::Base
  belongs_to :user

  has_many :outfit_article_of_clothings
  has_many :outfits, through: :outfit_article_of_clothings

  validates :user, presence: true
  validates :description, presence: true
end
