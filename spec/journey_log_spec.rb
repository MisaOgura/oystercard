require 'journey_log'

describe JourneyLog do

  let(:journey_class) { double(:journey_class, new: journey) }
  subject(:log) { described_class.new(journey_class: journey_class) }
  let(:journey) { double(:journey, begin_journey: nil, end_journey: nil, current: nil) }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:history) { {entry: nil, exit: nil} }

  describe '#initialize' do
    it '1.0 creats Jounry class as an instance variable' do
      expect(log.journey_class).to eq journey_class
    end
    it '1.1 creats a history as an empty array' do
      expect(log.history).to eq []
    end
  end

  describe '#start' do
    # it '2.0 creats a journey object' do
    #   expect(log.start(entry_station)).to be_a Journey
    # end
    it '2.0 calls begin_journey on a journey object' do
      log.start(entry_station)
      expect(journey).to have_received(:begin_journey).with(entry_station)
    end
  end

  describe '#finish' do
    it '3.0 calls end_journey on a journey object' do
      expect(journey).to receive(:end_journey).with(exit_station)
      log.finish(exit_station)
    end
  end
end
