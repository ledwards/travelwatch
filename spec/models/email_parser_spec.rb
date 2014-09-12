require 'rails_helper'

describe EmailParser do
  before do
    @user = User.create!(email: "leeredwards@gmail.com", password: "password")
  end

  it "parses the One-Way email correctly" do
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

    expect(@user.trips.first.flight_plans.map(&:id)).to eq([fp.id])
  end

  it "parses the Round Trip email correctly" do
    f = File.open("spec/fixtures/roundtrip.xml")
    doc = Nokogiri::XML(f)
    f.close

    EmailParser.import!(doc)
    fp1, fp2 = @user.flight_plans

    # expect(FlightPlan.count).to eq(2)
    # expect(@user.trips.first.flight_plans.map(&:id)).to eq([fp1.id, fp2.id])

    expect(fp1.departure_airport_code).to eq("JFK")
    expect(fp2.departure_airport_code).to eq("PBI")
  end
end