require 'journey_log'

describe JourneyLog do

  subject(:log) { described_class.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#initialize' do
    it '1.0 initializes with log = []' do
      expect(log.public_last_log).to eq('No previous journey')
    end
  end

  describe '#start' do
    it '2.0 calls a start method on journey' do
      log.start(entry_station)
      expect(log.public_last_log.entry_station).to eq(entry_station)
    end
  end

  describe '#finish' do
    it '3.0 calls a finish method on journey' do
      log.start(entry_station)
      log.finish(exit_station)
      expect(log.public_last_log.exit_station).to eq(exit_station)
    end
  end

  describe '#public_last_log' do
    it '4.0 returns a last journey if exists' do
      log.start(entry_station)
      expect(log.public_last_log).to be_an_instance_of Journey
    end
    it 'returns a message if no previous journey exists' do
      expect(log.public_last_log).to eq('No previous journey')
    end
  end
end
