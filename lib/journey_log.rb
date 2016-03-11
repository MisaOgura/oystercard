require_relative 'journey'
class JourneyLog

  attr_reader :journey_class, :history, :entry, :exit, :fare

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(station)
    start_current_journey
    @journey.begin_journey(station)
    @journey.fare
  end

  def finish(station)
    finish_current_journey
    @journey.end_journey(station)
    @journey.fare
  end

  def last_fare
    @history[-1][:fare]
  end

  def last_entry
    @history[-1][:entry]
  end

  def last_exit
    @history[-1][:exit]
  end


  private

  def start_current_journey
    if @history.empty?
      new_journey
    elsif last_entry != nil || last_exit != nil
       new_journey
    else
      @history[-1]
    end
  end

  def finish_current_journey
    if @history.empty?
      new_journey
    elsif last_entry == nil && last_exit != nil || complete?
      new_journey
    end
  end

  def complete?
    last_entry != nil && last_exit != nil
  end

  def new_journey
    @journey = @journey_class.new
    @history << @journey.current
  end

end
