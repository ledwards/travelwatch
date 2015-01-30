class Trip
  attr_accessor :flight_plans, :hotel_bookings, :car_rentals

  def initialize(flight_plans = [], hotel_bookings = [], car_rentals = [])
    self.flight_plans = flight_plans
    self.hotel_bookings = hotel_bookings
    self.car_rentals = car_rentals

    # TODO: Fix car rental and hotel booking times
  end

  def round_trip?
    return false if flight_plans.empty?
    self.flight_plans.first.departure_airport_code == self.flight_plans.last.arrival_airport_code
  end

  def items
    (flight_plans + hotel_bookings + car_rentals).sort_by(&:start_at)
  end

  def destination
    return nil if flight_plans.empty?
    midpoint = flight_plans.length / 2 - 1
    flight_plans[midpoint].arrival_airport_code
  end

  def description
    desc = "#{items.first.start_at.strftime("%b %-d")} Trip"
    desc += " to #{destination}" if destination
    desc
  end

  def start_at
    items.first.start_at
  end

  def end_at
    items.last.end_at
  end

  def as_json(options = {})
    { flight_plans: flight_plans, hotel_bookings: hotel_bookings, car_rentals: car_rentals, description: description }
  end
end
