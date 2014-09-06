class CreateHotelBookings < ActiveRecord::Migration
  def change
    create_table :itinerary_bookings do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.integer :segment_id
      t.timestamps
    end

    add_index :hotel_bookings, :segment_id
  end
end
