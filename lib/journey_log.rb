class JourneyLog

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :journey_class

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @journeys << current_journey
    current_journey.start(station)
  end

  def finish(station)
    @journeys << current_journey if @journeys.empty?
    if @journeys[-1].exit_station.nil?
      @journeys[-1].finish(station)
    else
      @journeys << current_journey
      @journeys[-1].finish(station)
    end
  end

  def show_last_journey
    last_journey = @journeys[-1]
  end

  def charge
     @journeys[-1].fare
  end

private

  def current_journey
    (@journeys.empty? || @journeys[-1].complete?) ? journey_class.new : @journeys[-1]
  end

end
