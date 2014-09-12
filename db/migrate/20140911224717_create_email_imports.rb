class CreateEmailImports < ActiveRecord::Migration
  def change
    create_table :email_imports do |t|
      t.references :user
      t.string :status
      t.text :xml
      t.timestamps
    end

    add_column :flight_plans, :airline_code, :string
    add_column :flight_plans, :flight_number, :string
    add_column :flight_plans, :airline_name, :string
    add_column :flight_plans, :duration, :string
    add_column :flight_plans, :distance, :string
    add_column :flight_plans, :class_type, :string

    rename_column :flight_plans, :start_airport, :departure_airport_code
    add_column :flight_plans, :departure_airport_name, :string
    add_column :flight_plans, :departure_latitude, :float
    add_column :flight_plans, :departure_longitude, :float
    add_column :flight_plans, :departure_terminal, :string
    add_column :flight_plans, :departure_gate, :string

    rename_column :flight_plans, :end_airport, :arrival_airport_code
    add_column :flight_plans, :arrival_airport_name, :string
    add_column :flight_plans, :arrival_latitude, :float
    add_column :flight_plans, :arrival_longitude, :float
    add_column :flight_plans, :arrival_terminal, :string
    add_column :flight_plans, :arrival_gate, :string
  end
end
