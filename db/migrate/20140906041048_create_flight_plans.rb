class CreateFlightPlans < ActiveRecord::Migration
  def change
    create_table :flight_plans do |t|
    	t.datetime :start_at
    	t.datetime :end_at
    	t.string :start_airport
    	t.string :end_airport
      t.references :itinerary
      t.timestamps
    end
  end
end
