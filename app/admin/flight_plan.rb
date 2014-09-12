ActiveAdmin.register FlightPlan do

  permit_params :start_at, :end_at, :start_airport, :end_airport, :confirmation_code, :user_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :airline_code
      f.input :airline_name
      f.input :flight_number

      f.input :departure_airport_code
      f.input :departure_time, as: "datetime_picker"
      f.input :departure_airport_name
      f.input :departure_latitude
      f.input :departure_longitude
      f.input :departure_terminal
      f.input :departure_gate

      f.input :arrival_airport_code
      f.input :arrival_time, as: "datetime_picker"
      f.input :arrival_airport_name
      f.input :arrival_latitude
      f.input :arrival_longitude
      f.input :arrival_terminal
      f.input :arrival_gate

      f.input :confirmation_code
      f.input :duration
      f.input :distance
      f.input :class_type

      f.inputs "User" do
        f.input :user_id, :label => "Select a user:", :as => :select, :collection => User.all.map(&:email).zip(User.all.map(&:id))
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
