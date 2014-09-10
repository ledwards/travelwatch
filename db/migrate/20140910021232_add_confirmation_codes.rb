class AddConfirmationCodes < ActiveRecord::Migration
  def change
    add_column :flight_plans, :confirmation_code, :string
    add_column :hotel_bookings, :confirmation_code, :string
    add_column :car_rentals, :confirmation_code, :string
  end
end
