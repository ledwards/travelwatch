class AddMoreFieldsToHotelBookings < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state_code
      t.string :country_code
      t.string :country_name
      t.string :postal_code
      t.decimal :longitude, precision: 9, scale: 6
      t.decimal :latitude, precision: 9, scale: 6
    end

    add_column :hotel_bookings, :room, :string
    add_column :hotel_bookings, :hotel_phone, :string
    rename_column :hotel_bookings, :name, :hotel_name
    add_column :hotel_bookings, :address_id, :integer

    add_index :hotel_bookings, :address_id
    add_index :hotel_bookings, :user_id
  end
end
