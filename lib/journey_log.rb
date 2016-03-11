class JourneyLog

  attr_reader :journey_class, :history

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(station)
    journey = @journey_class.new
    journey.begin_journey(station)
  end

  private

  # def current_journey
  #
  # end

end
