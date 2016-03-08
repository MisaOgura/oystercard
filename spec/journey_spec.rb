require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station) { double(:station)}
  let(:exit_station) { double(:station)}

  describe '#initialize' do
    it 'creates a journey with complete attribute as true' do
      expect(journey.complete?).to eq true
    end
    it 'creates a hash with entry_station: []' do
      expect(journey.history[:entry_station]).to eq([])
    end
    it 'creates a hash with exit_station: []' do
      expect(journey.history[:exit_station]).to eq([])
    end
  end

  describe '#start_journey' do
    before(:each) do
      journey.start_journey(entry_station)
    end
    it 'starts a journey' do
      expect(journey.complete?).to eq false
    end
    it 'stores an entry_station to the history' do
      expect(journey.history[:entry_station]).to include entry_station
    end
  end

  describe '#end_journey' do
    before(:each) do
      journey.end_journey(exit_station)
    end
    it 'ends a journey' do
      expect(journey.complete?).to eq true
    end
    it 'stores an exit_station to the history' do
      expect(journey.history[:exit_station]).to include exit_station
    end
  end

  describe '#end_journey'

end
