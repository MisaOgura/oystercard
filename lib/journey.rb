class Journey
  attr_reader :entry, :exit, :current, :fare

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @current = { entry: nil, exit: nil, fare: 0}
  end

  def begin_journey(station)
    @current[:entry] = station
  end

  def end_journey(station)
    @current[:exit] = station
  end

  def fare
    complete? ? @current[:fare] = MIN_FARE : @current[:fare] = PENALTY_FARE
  end

  def complete?
    @current[:entry] != nil && @current[:exit] != nil
  end

end
