class EmailParser
  def self.import!(doc)
    status = doc.xpath("//status")[0].text
    from = doc.xpath("//headers/header[@name='From']")[0].attribute("value").text
    user_email = /[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+/.match(from)[0]
    user = User.find_by_email(user_email)
    EmailImport.create(user: user, status: status, xml: doc.to_xml)

    doc.xpath("//items/flight").each_with_index do |node, i|
      fp = FlightPlan.new
      fp.user = user

      fp.confirmation_code = node.xpath("provider-details/confirmation-number").text
      fp.airline_name = node.xpath("provider-details/name").text
      fp.airline_code = node.xpath("details").attribute("airline-code").text
      fp.flight_number = node.xpath("details").attribute("number").text

      fp.departure_latitude = node.xpath("departure/latitude").text.to_f
      fp.departure_longitude = node.xpath("departure/longitude").text.to_f
      fp.departure_airport_code = node.xpath("departure/airport-code").text
      fp.departure_airport_name = node.xpath("departure/name").text
      fp.departure_terminal = node.xpath("departure/terminal").text
      fp.departure_gate = node.xpath("departure/gate").text
      fp.start_at = DateTime.parse(node.xpath("departure/utc-date-time").text)

      fp.arrival_latitude = node.xpath("arrival/latitude").text.to_f
      fp.arrival_longitude = node.xpath("arrival/longitude").text.to_f
      fp.arrival_airport_code = node.xpath("arrival/airport-code").text
      fp.arrival_airport_name = node.xpath("arrival/name").text
      fp.arrival_terminal = node.xpath("arrival/terminal").text
      fp.arrival_gate = node.xpath("arrival/gate").text
      fp.end_at = DateTime.parse(node.xpath("arrival/utc-date-time").text)

      fp.save
    end

    doc.xpath("//items/hotel-reservation").each_with_index do |node, i|
      hotel = HotelBooking.new
      hotel.user = user
      hotel.address = Address.new

      hotel.confirmation_code = node.xpath("provider-details/confirmation-number").text
      hotel.hotel_name = node.xpath("provider-details/name").text
      hotel.hotel_phone = node.xpath("provider-details/phone").text
      hotel.room = node.xpath("room").text

      hotel.address.latitude = node.xpath("address/latitude").text.to_f
      hotel.address.longitude = node.xpath("address/longitude").text.to_f
      hotel.address.street = node.xpath("address/street").text
      hotel.address.city = node.xpath("address/city").text
      hotel.address.state_code = node.xpath("address/state-code").text
      hotel.address.country_code = node.xpath("address/country-code").text
      hotel.address.country_name = node.xpath("address/country-name").text
      hotel.address.postal_code = node.xpath("address/postal-code").text

      hotel.start_at = DateTime.parse(node.xpath("check-in").text)
      hotel.end_at = DateTime.parse(node.xpath("check-out").text)

      hotel.save
    end

    doc.xpath("//items/car-rental").each_with_index do |node, i|
      car = CarRental.new
      car.user = user
      car.pickup_address = Address.new
      car.dropoff_address = Address.new

      car.confirmation_code = node.xpath("provider-details/confirmation-number").text
      car.company_name = node.xpath("provider-details/name").text
      car.car_type = node.xpath("car-type").attribute("name").value
      car.notes = node.xpath("notes").text

      car.pickup_address.latitude = node.xpath("pickup/address/latitude").text.to_f
      car.pickup_address.longitude = node.xpath("pickup/address/longitude").text.to_f
      car.pickup_address.street = node.xpath("pickup/address/street").text
      car.pickup_address.city = node.xpath("pickup/address/city").text
      car.pickup_address.state_code = node.xpath("pickup/address/state-code").text
      car.pickup_address.country_code = node.xpath("pickup/address/country-code").text
      car.pickup_address.country_name = node.xpath("pickup/address/country-name").text
      car.pickup_address.postal_code = node.xpath("pickup/address/postal-code").text
      car.pickup_phone = node.xpath("pickup/phone").text

      car.dropoff_address.latitude = node.xpath("dropoff/address/latitude").text.to_f
      car.dropoff_address.longitude = node.xpath("dropoff/address/longitude").text.to_f
      car.dropoff_address.street = node.xpath("dropoff/address/street").text
      car.dropoff_address.city = node.xpath("dropoff/address/city").text
      car.dropoff_address.state_code = node.xpath("dropoff/address/state-code").text
      car.dropoff_address.country_code = node.xpath("dropoff/address/country-code").text
      car.dropoff_address.country_name = node.xpath("dropoff/address/country-name").text
      car.dropoff_address.postal_code = node.xpath("dropoff/address/postal-code").text
      car.dropoff_phone = node.xpath("dropoff/phone").text

      car.start_at = DateTime.parse(node.xpath("pickup/utc-date-time").text)
      car.end_at = DateTime.parse(node.xpath("dropoff/utc-date-time").text)

      car.save
    end
  end
end
