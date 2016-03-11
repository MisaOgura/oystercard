require_relative 'journey'

class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE  = 2

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    error = "Error insufficient funds"
    raise error if @balance < MIN_LIMIT
    if @journey.current[:entry] != nil
      @balance -= @journey.fare
    end
    @journey.begin_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    @balance -= journey.fare
    @journey.reset
  end
end
