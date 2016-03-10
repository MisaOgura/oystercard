class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MESSAGE1 = "Balance cannot exceed £#{MAX_BALANCE}"
  MESSAGE2 = "Need at least £#{MIN_BALANCE} to touch in"

  attr_reader :balance

  def initialize(journey_log_class: JourneyLog.new)
    @journey_log_class = journey_log_class
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise MESSAGE1 if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise MESSAGE2 if balance < MIN_BALANCE
    @journey_log_class.entry(station)
  end

  def touch_out(station)
    @journey_log_class.exit(station)
    deduct(@journey_log_class.access_journeys.fare)
  end

  def journey_log_class
    @@journey_log_class.dup
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
