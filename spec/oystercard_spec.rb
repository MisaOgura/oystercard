require 'oystercard'

describe Oystercard do

  default_balance = Oystercard::DEFAULT_BALANCE
  max_balance = Oystercard::MAX_BALANCE
  min_balance = Oystercard::MIN_BALANCE

  subject(:card) { described_class.new }
  let(:entry_station) { double(:station, name: 'holborn', zone: 1) }
  let(:exit_station) { double(:station, name: 'arsenal', zone: 2) }

  describe '#initialize' do
    it '1.0 initializes with a default balance' do
      expect(card.balance).to eq(default_balance)
    end
    it '1.1 initializes with a journey log' do
      expect(card.journey_log).to be_an_instance_of JourneyLog
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
    it '3.1 deducst a penalty fare for invalid touch_in' do
      card.top_up(10)
      2.times {card.touch_in(entry_station)}
      fare = card.journey_log.public_last_log.fare
      expect(card.balance).to eq(10 - fare)
    end
  end

  describe '#touch_out' do
    it '4.1 deducts an appropriate fare for complete joruney' do
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      fare = card.journey_log.public_last_log.fare
      expect(card.balance).to eq 10 - fare
    end
    it '4.2 deducts a penalty fare for invalid touch_out' do
      card.top_up(10)
      card.touch_out(exit_station)
      fare = card.journey_log.public_last_log.fare
      expect(card.balance).to eq 10 - fare
    end
  end

  describe '#view_history' do
    it '5.0 shows a list of journey in string' do
      expect(card.view_history).to be_an_instance_of String
    end
  end
end
