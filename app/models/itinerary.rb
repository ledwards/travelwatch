class Itinerary < ActiveRecord::Base
	has_many :segments
	belongs_to :traveler

	# attr_accessor :name

	def ordered_segments

	end

end
