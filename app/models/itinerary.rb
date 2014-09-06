class Itinerary < ActiveRecord::Base
  has_many :flight_plans
  has_many :car_rentals
  has_many :hotel_bookings

  accepts_nested_attributes_for :flight_plans, allow_destroy: true
  accepts_nested_attributes_for :car_rentals, allow_destroy: true
  accepts_nested_attributes_for :hotel_bookings, allow_destroy: true

  def ordered_items
    # returns an array of flights, car rentals, and hotel bookings in the correct order
  end
end
