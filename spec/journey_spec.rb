require 'journey'

describe Journey do

  min_fare = Journey::MIN_FARE
  penalty_fare = Journey::PENALTY_FARE

  subject(:journey) { described_class.new }
  let(:entry_station) { double(:station, name: 'holborn', zone: 1) }
  let(:exit_station) { double(:station, name: 'arsenal', zone: 2) }

  describe '#iniialize' do
    it '1.0 initializes with entry_station = nil' do
      expect(journey.entry_station).to eq(nil)
    end
    it '1.1 initializes with exit_station = nil' do
      expect(journey.exit_station).to eq(nil)
    end
  end

  describe '#start' do
    it '2.0 remembers entry station' do
      expect(journey.start(entry_station)).to eq(entry_station)
    end
  end

  describe '#finish' do
    it '3.0 remembers exit station' do
      expect(journey.finish(exit_station)).to eq(exit_station)
    end
  end

  describe '#fare' do
    it '4.0 returns a minimal fare for a complete journey' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.fare).to eq 2
    end
    it '4.1 returns a penalty fare for an incomplete journey' do
      journey.finish(exit_station)
      expect(journey.fare).to eq penalty_fare
    end
  end
end
