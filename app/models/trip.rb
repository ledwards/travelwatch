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
    self.flight_plans.first.start_airport == self.flight_plans.last.end_airport
  end

  def items
    (flight_plans + hotel_bookings + car_rentals).sort_by(&:start_at)
  end

  def destination
    return nil if flight_plans.empty?
    midpoint = flight_plans.length / 2 - 1
    flight_plans[midpoint].end_airport
  end

  def start_at
    items.first.start_at
  end

  def end_at
    items.last.end_at
  end
end