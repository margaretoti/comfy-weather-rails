class OutfitArticleOfClothing < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :article_of_clothing

  validates :outfit, presence: true
  validates :article_of_clothing, presence: true
end
