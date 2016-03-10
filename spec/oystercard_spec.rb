require 'oystercard'

describe Oystercard do

  default_balance = Oystercard::DEFAULT_BALANCE
  max_balance = Oystercard::MAX_BALANCE
  min_balance = Oystercard::MIN_BALANCE

  subject(:card) { described_class.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#initialize' do
    it '1.0 initializes with a default balance' do
      expect(card.balance).to eq(default_balance)
    end
    it '1.1 initializes with journeys = []' do
      expect(card.journeys).to eq([])
    end
  end

  describe '#top_up' do
    it '2.0 increases balance by a given amount' do
      amount = rand(10..50)
      expect{card.top_up(amount)}.to change{card.balance}.by(amount)
    end
    it '2.1 raises an error when trying to top_up above max balance' do
      amount = rand((max_balance - card.balance + 1)..100)
      message = "Balance cannot exceed £#{max_balance}"
      expect{card.top_up(amount)}.to raise_error message
    end
  end

  describe '#touch_in' do
    it '3.0 raises an error when balance is below min balance' do
      message = "Need at least £#{min_balance} to touch in"
      expect{card.touch_in(entry_station)}.to raise_error message
    end
    it '3.1 creates a journey object' do
      card.top_up(10)
      card.touch_in(entry_station)
      expect(card.journey).to be_an_instance_of Journey
    end
  end

  describe '#touch_out' do
    before(:each) do
      card.top_up(10)
      card.touch_in(entry_station)
    end
    it '4.0 calls finish method on a journey object' do
      expect(card.journey).to receive(:finish)
      card.touch_out(exit_station)
    end
    it '4.1 deducts a fare' do
      card.touch_out(exit_station)
      expect(card.balance).to eq 10 - card.journey.fare
    end
  end
end
