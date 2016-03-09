require 'oystercard'

describe Oystercard do

  default_balance = Oystercard::DEFAULT_BALANCE
  maximum = Oystercard::MAXIMUM
  minimum = Oystercard::MINIMUM
  min_fare = Oystercard::MIN_FARE

  subject(:card) { described_class.new }
  let(:entry_station) { double(:station)}
  let(:exit_station) { double(:station)}

  describe '#initialize' do
    it 'instantiates a card with a default_balance' do
      expect(card.balance).to eq default_balance
    end
    it 'instantiates a card with a Journey class object' do
      expect(card.journey).to be_an_instance_of(Journey)
    end
  end

  describe '#top_up' do
    it 'raises an error when maximum balance exceeded' do
      amount = Random.rand((maximum + 1 - card.balance)..100)
      message = "maximum balance is £#{maximum}"
      expect{card.top_up(amount)}.to raise_error message
    end
    it 'adds money to the balance' do
      amount = Random.rand(5..10)
      expect(card.top_up(amount)).to eq (default_balance + amount)
    end
  end

  describe '#touch_in' do
    it 'raise an error when balance below £1' do
      empty_card = described_class.new(0)
      message = "need minimum £#{minimum} to touch-in"
      expect{empty_card.touch_in entry_station}.to raise_error message
    end
    it 'calls start_journey method on journey' do
      expect(card.journey).to receive(:start_at)
      card.touch_in entry_station
    end
  end

  describe '#touch_out' do
    it 'calls end_journey method on journey' do
      expect(card.journey).to receive(:end_at)
      card.touch_out exit_station
    end
    it 'deducts a fare from the card' do
      expect{card.touch_out(exit_station)}.to change{card.balance}.by(-min_fare)
    end
  end
end
