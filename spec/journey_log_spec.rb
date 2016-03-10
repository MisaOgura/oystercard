require 'journey_log'

describe JourneyLog do
  subject(:journey_log) {described_class.new}
  let(:entry_station) { double(:station, name: 'holborn', zone: 1) }
  let(:exit_station) { double(:station, name: 'kew garden', zone: 4) }

  describe '#initialize' do
    it '1.0 has a journeys method that initially returns an empty array' do
    expect(journey_log.journeys).to be_empty
    end
  end

  describe '#start' do
    it '2.0 creates a new journey and ammends an entry station' do
      journey_log.entry(entry_station)
      expect(journey_log.journeys[-1].entry_station).to eq entry_station
    end
  end

  describe '#exit' do
    before(:each) do
      journey_log.entry(entry_station)
      journey_log.exit(exit_station)
    end
    it '3.0 completes a journey with an exit station' do
      expect(journey_log.journeys[-1].exit_station).to eq exit_station
    end
    it '3.1 logs incomplete journey' do
      journey_log.exit(exit_station)
      expect(journey_log.journeys[-1].entry_station).to eq nil
    end
    it '3.2 creates a new journey if the last journey is incomplete' do
      journey_log.exit(exit_station)
      journey_log.exit(exit_station)
      expect(journey_log.journeys.length).to eq 3
    end
  end
end
