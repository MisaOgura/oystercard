class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MESSAGE1 = "Balance cannot exceed £#{MAX_BALANCE}"
  MESSAGE2 = "Need at least £#{MIN_BALANCE} to touch in"

  attr_reader :balance, :journey_log

  def initialize(journey_log_class: JourneyLog)
    @journey_log = journey_log_class.new
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise MESSAGE1 if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise MESSAGE2 if balance < MIN_BALANCE
    deduct(last_fare) unless first_journey? || last_journey_complete?
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct(last_fare)
  end

  private

  def first_journey?
    @journey_log.public_history.length == 0
  end

  def last_journey_complete?
    @journey_log.public_last_log.complete?
  end

  def last_fare
    @journey_log.public_last_log.fare
  end

  def deduct(amount)
    @balance -= amount
  end
end
