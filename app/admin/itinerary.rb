ActiveAdmin.register Itinerary do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.has_many :flight_plans, heading: 'Flights', allow_destroy: true, new_record: 'New Flight' do |fp|
        fp.inputs
      end
      f.has_many :hotel_bookings, heading: 'Hotels', allow_destroy: true, new_record: 'New Hotel' do |hb|
        hb.inputs
      end
      f.has_many :car_rentals, heading: 'Car Rentals', allow_destroy: true, new_record: 'New Car Rental' do |cr|
        cr.inputs
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
