class Outfit < ActiveRecord::Base
  validates :rating, presence: true
  validates :notes, length: { maximum: 250 }
end
