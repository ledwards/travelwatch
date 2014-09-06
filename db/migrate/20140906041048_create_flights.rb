class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
    	t.datetime :start_at
    	t.datetime :end_at
    	t.string :start_airport
    	t.string :end_airport
      t.integer :segment_id
      t.timestamps
    end

    add_index :flights, :segment_id
  end
end
