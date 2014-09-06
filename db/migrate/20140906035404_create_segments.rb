class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
    	t.integer :itinerary_id
      t.timestamps
    end

    add_index :segments, :itinerary_id
  end
end
