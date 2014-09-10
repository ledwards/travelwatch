ActiveAdmin.register FlightPlan do

  permit_params :start_at, :end_at, :start_airport, :end_airport, :confirmation_code, :user_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :start_at, as: "datetime_picker"
      f.input :end_at, as: "datetime_picker"
      f.input :start_airport
      f.input :end_airport
      f.input :confirmation_code
      f.inputs "User" do
        f.input :user_id, :label => "Select a user:", :as => :select, :collection => User.all.map(&:email).zip(User.all.map(&:id))
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
