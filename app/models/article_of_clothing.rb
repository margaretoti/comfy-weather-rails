class ArticleOfClothing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :outfit_article_of_clothings
  has_many :outfits, through: :outfit_article_of_clothings

  validates :user, presence: true
  validates :category, presence: true
  validates :description, presence: true

  def frequency
    self.outfit_article_of_clothings.count
  end
end
