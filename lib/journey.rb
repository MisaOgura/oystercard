class Journey
  attr_reader :entry, :exit, :current

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @current = { entry: nil, exit: nil }
  end

  def begin_journey(station)
    @current[:entry] = station
  end

  def end_journey(station)
    @current[:exit] = station
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

end
