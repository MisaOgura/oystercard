require 'journey_log'

describe JourneyLog do

  min_fare = JourneyLog::MIN_FARE
  penalty_fare = JourneyLog::PENALTY_FARE

  subject(:journey_log) { described_class.new }
  let(:entry_station) { double(:station)}
  let(:exit_station) { double(:station)}

  it { is_expected.to respond_to(:start).with(1).argument}
  it { is_expected.to respond_to(:finish).with(1).argument }

  describe '#initialize' do
    it 'should receive a Journey_class parameter' do
      expect(journey_log.journey_class).to eq Journey
    end
  end

  describe '#start' do
    it 'should store current_journey to journeys' do
      journey_log.start(entry_station)
      expect(journey_log.show_last_journey.entry_station).to eq entry_station
    end
  end

  describe '#finish' do
    it 'shoudl store a new journey if journeys is empty' do
      journey_log.finish(exit_station)
      expect(journey_log.show_last_journey.exit_station).to eq exit_station
    end
    it 'should assign an exit station to existing journey' do
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      expect(journey_log.show_last_journey.exit_station).to eq exit_station
    end
  end

  describe '#show_last_journey' do
    it 'should show the last journey stored in journeys' do
      journey_log.start(entry_station)
      expect(journey_log.show_last_journey).to be_an_instance_of Journey
    end
  end

  describe '#charge' do
    it 'should return a min fare for the complete journey' do
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      expect(journey_log.charge).to eq min_fare
    end
    it 'should return a penalty fare for an invalid touch in' do
      journey_log.start(entry_station)
      journey_log.start(entry_station)
      expect(journey_log.charge).to eq penalty_fare
    end
    it ' should return a penalty fare for an invalid touch out' do
      journey_log.finish(exit_station)
      journey_log.finish(exit_station)
      expect(journey_log.charge).to eq penalty_fare
    end
  end
end
