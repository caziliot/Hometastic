class AvailableMonth < ApplicationRecord
  belongs_to :flat
  validates_date :month_year, after: -> { Date.current }, message: "date must be after today"
end
