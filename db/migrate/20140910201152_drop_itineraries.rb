class DropItineraries < ActiveRecord::Migration
  def up
    drop_table :itineraries
    remove_column :hotel_bookings, :itinerary_id
    remove_column :car_rentals, :itinerary_id
  end

  def down
    create_table :itineraries do |t|
      t.string :name
      t.timestamps
      t.references :user
    end
    add_column :hotel_bookings, :itinerary_id, :integer
    add_column :car_rentals, :itinerary_id, :integer
  end
end
