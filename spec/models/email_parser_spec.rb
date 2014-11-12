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

    f = File.open("spec/fixtures/car.xml")
    doc = Nokogiri::XML(f)
    f.close

    EmailParser.import!(doc)
    car = CarRental.last

    expect(car.user.email).to eq("spolsky@fogcreek.com")

    expect(car.confirmation_code).to eq("G3234540965")
    expect(car.company_name).to eq("Hertz")
    expect(car.car_type).to eq("Midsize SUV")
    expect(car.notes).to eq("Drop Off Opening Hours: Mon-Sun 05.00-02.00\nPick Up Opening Hours: Mon-Sun 05.00-02.00")

    expect(car.pickup_address.latitude).to eq(40.786639)
    expect(car.pickup_address.longitude).to eq(-111.984095)
    expect(car.pickup_address.street).to eq("Salt Lake City International Airport 775 North Terminal Drive")
    expect(car.pickup_address.city).to eq("Salt Lake City")
    expect(car.pickup_address.state_code).to eq("UT")
    expect(car.pickup_address.country_code).to eq("US")
    expect(car.pickup_address.country_name).to eq("United States")
    expect(car.pickup_address.postal_code).to eq("84122")

    expect(car.dropoff_address.latitude).to eq(40.786639)
    expect(car.dropoff_address.longitude).to eq(-111.984095)
    expect(car.dropoff_address.street).to eq("Salt Lake City International Airport 775 North Terminal Drive")
    expect(car.dropoff_address.city).to eq("Salt Lake City")
    expect(car.dropoff_address.state_code).to eq("UT")
    expect(car.dropoff_address.country_code).to eq("US")
    expect(car.dropoff_address.country_name).to eq("United States")
    expect(car.dropoff_address.postal_code).to eq("84122")

    expect(car.pickup_phone).to eq("801-575-2683")
    expect(car.dropoff_phone).to eq("801-575-2683")

    expect(car.start_at).to eq(DateTime.parse("2014-09-29T22:00:00.000Z"))
    expect(car.end_at).to eq(DateTime.parse("2014-09-30T13:30:00.000Z"))

    expect(user.trips.first.car_rentals.map(&:id)).to eq([car.id])
  end
end
