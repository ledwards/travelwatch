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
  end
end