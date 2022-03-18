class AvailableMonth < ApplicationRecord
  # This class represents all the months historicly that the owner put as available.
  belongs_to :flat
  validates_date :month_year, after: -> { Date.current }, message: "date must be after today", on: :create
  validates_uniqueness_of :month_year, scope: :flat_id
  validates :month_year, presence: true

  def take
    update(taken: true)
  end
end
