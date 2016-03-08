class Oystercard
  DEFAULT_BALANCE = 5
  MAXIMUM = 90
  MINIMUM = 1
  MIN_FARE = 2

  attr_reader :balance, :journey

  def initialize(balance=DEFAULT_BALANCE, journey=Journey.new)
    @balance = balance
    @journey = journey
  end

  def top_up amount
    if @balance + amount > MAXIMUM
      raise "maximum balance is £#{MAXIMUM}"
    end
    @balance += amount
  end

  def touch_in entry_station
    raise "need minimum £#{MINIMUM} to touch-in" if @balance < MINIMUM
    @journey.start_journey(entry_station)
  end

  def touch_out exit_station
    @journey.end_journey(exit_station)
    deduct MIN_FARE
  end

  private

  def deduct (amount)
    # raise 'balance below zero' if @balance - amount < 0
    @balance -= amount
  end
end
