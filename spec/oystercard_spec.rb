require 'oystercard'

describe Oystercard do

  default_balance = Oystercard::DEFAULT_BALANCE
  max_balance = Oystercard::MAX_BALANCE
  min_balance = Oystercard::MIN_BALANCE

  subject(:card) { described_class.new }
  let(:entry_station) { double(:station, name: "Shoreditch", zone: 1) }
  let(:exit_station) { double(:station, name: "Hoxton", zone: 6 ) }
  let(:journey) { double(:journey, entry_station: entry_station, exit_station: exit_station) }

  describe '#initialize' do
    it '1.0 initializes with a default balance' do
      expect(card.balance).to eq(default_balance)
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
  end

  describe '#touch_out' do
    before(:each) do
      card.top_up(10)
      card.touch_in(entry_station)
    end
    it "deducts the correct fare" do
        allow(journey).to receive(:fare).and_return 6
        expect{card.touch_out(exit_station)}.to change{card.balance}.by -journey.fare
    end
  end
end
