class Oystercard
  DEFAULT_BALANCE = 5

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def check_balance
    balance
  end

  def topup (amount)
    @balance += amount
  end

  private
  attr_reader :balance
end
