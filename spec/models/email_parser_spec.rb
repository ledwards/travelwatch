require 'rails_helper'

describe EmailParser do
  it "parses the One-Way email correctly" do
    user = User.create!(email: "leeredwards@gmail.com", password: "password")

    f = File.open("spec/fixtures/oneway.xml")
    doc = Nokogiri::XML(f)
    f.close

    EmailParser.import!(doc)
    fp = FlightPlan.last

    expect(fp.user.email).to eq("leeredwards@gmail.com")

    expect(fp.confirmation_code).to eq("ABCDEF")
    expect(fp.airline_code).to eq("B6")
    expect(fp.flight_number).to eq("153")
    expect(fp.airline_name).to eq("Jetblue Airways Corporation")

    expect(fp.departure_latitude).to eq(40.63)
    expect(fp.departure_longitude).to eq(-73.77)
    expect(fp.departure_airport_code).to eq("JFK")
    expect(fp.departure_airport_name).to eq("John F. Kennedy International Airport")
    expect(fp.departure_terminal).to eq("5")
    expect(fp.departure_gate).to eq("12")
    expect(fp.start_at).to eq(DateTime.parse("2014-08-22 22:50:00"))

    expect(fp.arrival_latitude).to eq(26.68)
    expect(fp.arrival_longitude).to eq(-80.09)
    expect(fp.arrival_airport_code).to eq("PBI")
    expect(fp.arrival_airport_name).to eq("West Palm Beach International Airport")
    expect(fp.arrival_terminal).to eq("A")
    expect(fp.arrival_gate).to eq("1")
    expect(fp.end_at).to eq(DateTime.parse("2014-08-23 01:51:00"))

    expect(user.trips.first.flight_plans.map(&:id)).to eq([fp.id])
  end

  it "parses the Round Trip email correctly" do
    user = User.create!(email: "leeredwards@gmail.com", password: "password")

    f = File.open("spec/fixtures/roundtrip.xml")
    doc = Nokogiri::XML(f)
    f.close

    EmailParser.import!(doc)
    fp1, fp2 = user.flight_plans

    expect(user.trips.first.flight_plans.map(&:id)).to eq([fp1.id, fp2.id])
    expect(fp1.departure_airport_code).to eq("JFK")
    expect(fp2.departure_airport_code).to eq("SFO")
  end

  it "parses the hotel email correctly" do
    user = User.create!(email: "spolsky@fogcreek.com", password: "password")

    f = File.open("spec/fixtures/hotel.xml")
    doc = Nokogiri::XML(f)
    f.close

    EmailParser.import!(doc)
    hotel = HotelBooking.last

    expect(hotel.user.email).to eq("spolsky@fogcreek.com")

    expect(hotel.confirmation_code).to eq("12345")
    expect(hotel.hotel_name).to eq("Hilton Garden Inn Salt Lake City Airport")
    expect(hotel.hotel_phone).to eq("1 (801) 519-9000")
    expect(hotel.room).to eq("Two Queen Beds")

    expect(hotel.address.latitude).to eq(40.77352)
    expect(hotel.address.longitude).to eq(-112.01327)
    expect(hotel.address.street).to eq("4975 Wiley Post Way")
    expect(hotel.address.city).to eq("Salt Lake City")
    expect(hotel.address.state_code).to eq("UT")
    expect(hotel.address.country_code).to eq("US")
    expect(hotel.address.country_name).to eq("United States")
    expect(hotel.address.postal_code).to eq("84116")

    expect(hotel.start_at).to eq(DateTime.parse("2014-09-29Z"))
    expect(hotel.end_at).to eq(DateTime.parse("2014-09-30Z"))

    expect(user.trips.first.hotel_bookings.map(&:id)).to eq([hotel.id])
  end
end
