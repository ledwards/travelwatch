class CreateHotelBookings < ActiveRecord::Migration
  def change
    create_table :hotel_bookings do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.references :itinerary
      t.timestamps
    end
  end
end
