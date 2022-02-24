class AvailableMonth < ApplicationRecord
  # This class represents all the months historicly that the owner put as available.
  belongs_to :flat
  validates_date :month_year, after: -> { Date.current }, message: "date must be after today"
  validates_uniqueness_of :month_year, scope: :flat_id
  validates :month_year, presence: true

  def take
    self.taken = true
  end
end
