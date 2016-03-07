class Oystercard
  DEFAULT_BALANCE = 5
  MAXIMUM = 90
  MINIMUM = 1

  attr_reader :in_journey
  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def check_balance
    balance
  end

  def topup (amount)
    if @balance + amount > MAXIMUM
      raise "maximum balance is £#{MAXIMUM}"
    end
    @balance += amount
  end

  def deduct (amount)
    raise 'balance below zero' if @balance - amount < 0
    @balance -= amount
  end

  def touch_in
    raise 'need minimum £1 to touch-in' if @balance < MINIMUM
    in_journey?
  end

  def touch_out
    in_journey?
  end

  private
  attr_reader :balance

  def in_journey?
    !@in_journey
  end
end
