class BookingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :reviews, dependent: :destroy

  validates :user, presence: true
end
