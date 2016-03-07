class Oystercard
  DEFAULT_BALANCE = 5
  DEFAULT_MAXIMUM = 90

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def check_balance
    balance
  end

  def topup (amount)
    if @balance + amount > DEFAULT_MAXIMUM
      raise "maximum balance is £#{DEFAULT_MAXIMUM}"
    end
    @balance += amount
  end

  private
  attr_reader :balance
end
