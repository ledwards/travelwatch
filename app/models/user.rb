class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :flight_plans
  has_many :hotel_bookings
  has_many :car_rentals

  def trip_items
    (flight_plans + hotel_bookings + car_rentals).order(:start_at)
  end

  def location_at(time)
    # TODO: This should return a Location object (city/state/country/zip, long/lat, nearest airport)
    plans = flight_plans.order(:start_at)
    return home_airport if time < plans.first.start_at || time > plans.last.end_at
    plans.each do |fp|
      if time <= fp.start_at
        return fp.start_airport
      elsif time >= fp.start_at && time <= fp.end_at
        return nil # in transit
      else
        next
      end
    end
  end

  def home_airport
    return flight_plans.order(:start_at).first.start_airport
  end

  def trips
    trips = []
    flight_plans.order(:start_at).each do |fp|
      if fp.start_airport == home_airport
        trips << Trip.new([fp])
      else
        trips.last.flight_plans << fp
      end
    end

    return trips
  end
end
