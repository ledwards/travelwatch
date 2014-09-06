class CreateCarRentals < ActiveRecord::Migration
  def change
    create_table :car_rentals do |t|
    	t.string :company
    	t.datetime :start_at
    	t.datetime :end_at
      t.references :itinerary
      t.timestamps
    end
  end
end
