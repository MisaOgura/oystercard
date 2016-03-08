class Oystercard
  DEFAULT_BALANCE = 5
  MAXIMUM = 90
  MINIMUM = 1
  MINIMUM_FARE = 2

  attr_reader :balance, :origin, :journeys

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @origin = nil
    @journeys = {}
  end

  def top_up(amount)
    raise "cannot exceed maximum amount £#{MAXIMUM}" if @balance + amount > 90
    @balance += amount
  end

  def in_journey?
    @origin != nil
  end

  def touch_in(origin)
    raise 'insufficient funds.' if @balance < MINIMUM
    @origin = origin

  end

  def touch_out
    deduct(MINIMUM_FARE)
    @origin = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
