require 'oystercard'

describe Oystercard do
  let(:journey_log) {double(:journey_log, start: nil, finish: nil, history: [], last_entry: true, last_exit: nil, last_fare: 6)}
  subject(:card) { described_class.new(journey_log: journey_log)}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#initialize' do
    xit '1.0 creates a journey log' do
      expect(card.journey_log).to eq journey_log
    end
  end

  describe '#balance' do
    xit 'checks that new card has a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    before do
      card.top_up(20)
    end

    xit 'it adds 20 to balance' do
      expect(card.balance).to eq 20
    end

    xit 'raises an error if balance exceeds limit' do
      message = "Error, balance exceeds £#{Oystercard::MAX_LIMIT}!"
      expect{ card.top_up(100) }.to raise_error message
    end
  end

  describe '#touch_in' do
    xit 'raises error when balance insufficient' do
      message = "Error insufficient funds"
      expect{ card.touch_in(entry_station) }.to raise_error message
    end

    it 'charges a penatly if no touch_out' do
      card.top_up(20)
      card.touch_in(entry_station)
      all
      card.touch_in(entry_station)
      p card.balance
      # expect{card.touch_in(entry_station)}.to change{card.balance}.by -Journey::PENALTY_FARE
      expect(card.balance).to eq 14
    end

    xit 'returns beginning of current journey' do
      card.top_up(20)
      expect(journey_log).to receive(:start).with(entry_station)
      card.touch_in(entry_station)
    end
  end

  describe '#touch_out' do
    xit 'deducts fare from balance' do
      card.top_up(20)
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by -Journey::MIN_FARE
    end
    xit 'calls end_journey method on a JourneyLog' do
      card.top_up(20)
      expect(journey_log).to receive(:finish).with(exit_station)
      card.touch_out(exit_station)
    end
  end

end
