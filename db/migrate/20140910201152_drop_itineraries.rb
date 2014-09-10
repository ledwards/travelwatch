class DropItineraries < ActiveRecord::Migration
  def up
    drop_table :itineraries 
  end

  def down
    create_table :itineraries do |t|
      t.string :name
      t.timestamps
      t.references :user
    end
  end
end
