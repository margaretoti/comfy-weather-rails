class Outfit < ActiveRecord::Base
  validates :rating, presence: true
end
