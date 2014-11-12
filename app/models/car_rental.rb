class CarRental < ActiveRecord::Base
  belongs_to :user
  belongs_to :pickup_address, class_name: "Address"
  belongs_to :dropoff_address, class_name: "Address"
end
