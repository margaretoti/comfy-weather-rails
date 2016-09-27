class ArticleOfClothing < ActiveRecord::Base
  belongs_to :user

  has_many :outfits

  validates :description, presence: true
end
