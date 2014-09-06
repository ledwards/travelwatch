class Segment < ActiveRecord::Base
	has_many :flights
	has_many :car_rentals
	has_many :hotel_bookings

	def ordered_items
		# returns an array of flights, car rentals, and hotel bookings in the correct order
	end
end
