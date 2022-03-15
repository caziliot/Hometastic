class Flat < ApplicationRecord
  belongs_to :user
  has_many :chat_rooms
  has_many :booking_requests
  has_many :available_months, dependent: :destroy
  has_many :messages, through: :chatrooms
  has_many :reviews, through: :booking_requests
  has_many :amenities, dependent: :destroy
  has_many_attached :photos
  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  #validates :photos, presence: true
  validates :name, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_date_price_direction_city,
    against: [ :address, :price, :name ],
    using: {
      tsearch: { prefix: true }
    }

  def available?(date_s)
    month = available_months.find_by(month_year: date_s)
    return month.nil? ? false : !month.taken
  end

  def available_between?(date_s, date_e)
    months = available_months.select do |am|
      am.month_year.to_date >= date_s.to_date && am.month_year.to_date <= date_e.to_date && !am.taken
    end
    return months.any?
  end

  def edit_amenities(g_amenities_ids)
    puts "enter amenities-------"
    g_amenities_ids.inspect
    amenis = []
    GeneralAmenity.all.each do |ga|
      on_flat = amenities.find_by(title: ga.title)
      puts "on flat: #{on_flat&.title}"
      unless g_amenities_ids.include?(ga.id.to_s) && on_flat
        if g_amenities_ids.include?(ga.id.to_s)
          a = Amenity.new(title: ga.title, icon_class: ga.icon_class, flat_id: id)
          puts a
          amenis << a
        elsif on_flat
          puts "destroying #{on_flat.id}"
          on_flat.destroy!
        end
      end
    end
    Amenity.transaction do
      amenis.each do |a|
        puts "saving amenities"
        a.save!
      end
    end

  end

  def review_average
    sum = 0.0
    reviews.each do |r|
      sum+= r.rating
    end
    return (sum.to_f/reviews.size).round(1) if reviews.any?
  end
end
