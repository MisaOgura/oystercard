require 'oystercard'

describe Oystercard do
subject(:card) { described_class.new }
let(:entry_station) { double(:station)}
let(:exit_station) { double(:station)}
# let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

default_balance = Oystercard::DEFAULT_BALANCE
maximum = Oystercard::MAXIMUM
minimum = Oystercard::MINIMUM
single_fare = Oystercard::SINGLE_FARE

  describe '#initialize' do
    it 'creates a card with empty history' do
      expect(card.check_history.empty?).to eq true
    end
  end

  describe '#check_balance' do
    it 'has a balance' do
      expect(card.check_balance).to eq default_balance
    end
  end

  describe '#top_up' do
    it 'adds money to the balance' do
      amount = Random.rand(5..10)
      expect(card.top_up(amount)).to eq (default_balance + amount)
    end

    context 'when maximum balance exceeded' do
      it 'raises an error' do
        amount = Random.rand(100..200)
        message = "maximum balance is £#{maximum}"
        expect{card.top_up(amount)}.to raise_error message
      end
    end
  end

  describe '#touch_in' do

    it 'raise an error when balance below £1' do
      empty_card = described_class.new(0)
      message = "need minimum £#{minimum} to touch-in"
      expect{empty_card.touch_in entry_station}.to raise_error message
    end

    context 'when the balance is more than minimum' do

      before(:each) do
        card.touch_in entry_station
      end

      it 'changes in_journey? to true' do
        expect(card.in_journey?).to eq true
      end
    end
  end

  describe '#touch_out' do
    it 'changes in_journey? to false' do
      card.touch_out exit_station
      expect(card.in_journey?).to eq false
    end

    it 'deducts a fare from the card' do
      expect{card.touch_out(exit_station)}.to change{card.check_balance}.by(-single_fare)
    end
  end

  describe '#check_history' do

    it 'shows the history of one journey' do
      card.touch_in entry_station
      card.touch_out exit_station
      expect(card.check_history[entry_station]).to eq exit_station
    end
  end
end
