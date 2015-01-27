class AddMoreFieldsToCarRentals < ActiveRecord::Migration
  def change
    rename_column :car_rentals, :company, :company_name
    add_column :car_rentals, :car_type, :string

    add_column :car_rentals, :pickup_address_id, :integer
    add_column :car_rentals, :dropoff_address_id, :integer
    add_column :car_rentals, :pickup_phone, :string
    add_column :car_rentals, :dropoff_phone, :string
    add_column :car_rentals, :notes, :text

    add_index :car_rentals, :pickup_address_id
    add_index :car_rentals, :dropoff_address_id
    add_index :car_rentals, :user_id
  end
end
