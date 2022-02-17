class BookingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :reviews, dependent: :destroy
end
