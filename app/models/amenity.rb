class Amenity < ApplicationRecord
  belongs_to :flat

  validates :title, presence: true
end
