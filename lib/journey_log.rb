require_relative 'journey'
class JourneyLog

  attr_reader :journey_class, :history, :entry, :exit

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(station)
    current_journey
    @journey.begin_journey(station)
  end

  def finish(station)
    if @history[-1][:entry] == nil && @history[-1][:exit] != nil || complete?
      new_journey
    end
    @journey.end_journey(station)
  end

  private

  def new_journey
    @journey = @journey_class.new
    @history << @journey.current
  end

  def current_journey
    if @history.empty?
      new_journey
    elsif @history[-1][:entry] != nil || @history[-1][:exit] != nil
       new_journey
    else
      @history[-1]
    end
  end

  def complete?
    if @history[-1][:entry] != nil && @history[-1][:exit] != nil
     true
   else
    false
    end
  end
end

