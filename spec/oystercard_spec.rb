require 'oystercard'

describe Oystercard do
subject(:card) { described_class.new }
let(:entry_station) { double(:station)}
let(:exit_station) { double(:station)}
let(:a_journey) { {entry_station: entry_station, exit_station: exit_station} }
let(:journey) { double(:journey, start_journey: nil, end_journey: nil) }

default_balance = Oystercard::DEFAULT_BALANCE
maximum = Oystercard::MAXIMUM
minimum = Oystercard::MINIMUM
single_fare = Oystercard::SINGLE_FARE

  describe '#initialize' do
    it 'instantiates a card with a default_balance' do
      expect(card.balance).to eq default_balance
    end

    it 'instantiates a card with a Journey class object' do
      expect(card.journey).to be_an_instance_of(Journey)
    end
  end

  describe '#top_up' do
    it 'adds money to the balance' do
      amount = Random.rand(5..10)
      expect(card.top_up(amount)).to eq (default_balance + amount)
    end

    context 'when maximum balance exceeded' do
      it 'raises an error' do
        amount = Random.rand((maximum + 1 - card.balance)..100)
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

      it 'calls start_journey method on journey' do
        expect(card.journey).to receive(:start_journey)
        card.touch_in entry_station
      end

      it 'changes in_journey? to true' do
        expect(card.in_journey?).to eq true
      end
    end
  end

  describe '#touch_out' do
    # before(:each) do
    #   card.touch_out exit_station
    # end

    it 'calls end_journey method on journey' do
      expect(card.journey).to receive(:end_journey)
      card.touch_out exit_station
    end

    it 'changes in_journey? to false' do
      card.touch_out exit_station
      expect(card.in_journey?).to eq false
    end

    it 'deducts a fare from the card' do
      expect{card.touch_out(exit_station)}.to change{card.balance}.by(-single_fare)
    end
  end

  describe '#journeys' do

    it 'shows one journey' do
      card.touch_in entry_station
      card.touch_out exit_station
      expect(card.journeys).to include (a_journey)
    end
  end
end
