ActiveAdmin.register FlightPlan do

  permit_params :start_at, :end_at, :confirmation_code, :user_id, :duration, :distance, :class_type,
                :airline_code, :airline_name, :flight_number,
                :departure_latitude, :departure_longitude, :departure_terminal, :departure_gate,
                :departure_airport_code, :departure_airport_name,
                :arrival_latitude, :arrival_longitude, :arrival_terminal, :arrival_gate,
                :arrival_airport_code, :arrival_airport_name

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user_id, :label => "Select a user:", :as => :select, :collection => User.all.map(&:email).zip(User.all.map(&:id))

      f.input :airline_code
      f.input :airline_name
      f.input :flight_number

      f.input :start_at, as: "datetime_picker"
      f.input :end_at, as: "datetime_picker"

      f.input :departure_airport_code
      f.input :departure_airport_name
      f.input :departure_latitude
      f.input :departure_longitude
      f.input :departure_terminal
      f.input :departure_gate

      f.input :arrival_airport_code
      f.input :arrival_airport_name
      f.input :arrival_latitude
      f.input :arrival_longitude
      f.input :arrival_terminal
      f.input :arrival_gate

      f.input :confirmation_code
      f.input :duration
      f.input :distance
      f.input :class_type
    end

    f.actions
  end

end
