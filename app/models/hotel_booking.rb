class HotelBooking < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
end
