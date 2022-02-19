class Review < ApplicationRecord
  belongs_to :booking_request
  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [0, 1, 2, 3, 4, 5], allow_nil:false}
end
