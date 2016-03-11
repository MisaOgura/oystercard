require_relative 'journey_log'

class Oystercard
  attr_reader :balance, :journey_log

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize(journey_log: JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    error = "Error insufficient funds"
    raise error if @balance < MIN_LIMIT
    if !@journey_log.history.empty? && @journey_log.last_entry && @journey_log.last_exit == nil
      @balance -= @journey_log.last_fare
    end
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    @balance -= @journey_log.last_fare
  end
end
