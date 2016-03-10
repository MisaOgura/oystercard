class JourneyLog

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(station)
    new_journey.start(station)
  end

  def finish(station)
    current_journey.finish(station)
  end

  def public_last_log
    last_log.dup
  end

  def public_history
    @history.dup
  end

  private

  def current_journey
    last_log.complete? ? new_journey : last_log
  end

  def new_journey
    @history << @journey_class.new
    last_log
  end

  def last_log
    @history[-1].nil? ? 'No previous journey' : @history[-1]
  end
end
