require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station) { double(:station)}
  let(:exit_station) { double(:station)}
  let(:entry_log) { {entry_station: entry_station} }
  let(:exit_log) { {exit_station: exit_station} }



  describe '#initialize' do
    it 'instantiates a journey with complete attribute as true' do
      expect(journey.complete?).to eq true
    end

    it 'instantiates a journey with an empty hash: history' do
      expect(journey.history).to eq({})
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
      expect(journey.history).to include entry_log
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      journey.end_journey(exit_station)
      expect(journey.complete?).to eq true
    end

    it 'stores an exit_station to the history' do
      journey.end_journey(exit_station)
      expect(journey.history).to include exit_log
    end
  end

end
