

class Oystercard
  DEFAULT_BALANCE = 5
  MAXIMUM = 90
  MINIMUM = 1
  SINGLE_FARE = 2

  attr_reader :balance, :journeys

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @journeys = {}
  end

  def top_up amount
    if @balance + amount > MAXIMUM
      raise "maximum balance is £#{MAXIMUM}"
    end
    @balance += amount
  end

  def touch_in entry_station
    @journeys[:entry_station] = entry_station
    raise "need minimum £#{MINIMUM} to touch-in" if @balance < MINIMUM
    in_journey?
  end

  def touch_out exit_station
    @journeys[:exit_station] = exit_station
    deduct SINGLE_FARE
    in_journey?
  end

  def in_journey?
    journeys.keys.include?(:entry_station)
  end

  private

  def deduct (amount)
    raise 'balance below zero' if @balance - amount < 0
    @balance -= amount
  end
end
