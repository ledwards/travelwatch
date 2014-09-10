class AddUserIds < ActiveRecord::Migration
  def change
    change_table :flight_plans do |t|
      t.references :user
    end

    change_table :hotel_bookings do |t|
      t.references :user
    end

    change_table :car_rentals do |t|
      t.references :user
    end

    change_table :itineraries do |t|
      t.references :user
    end
  end
end
