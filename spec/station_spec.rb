require 'station'

describe Station do

subject(:station) { described_class.new('Turnpike Lane') }

  describe '#initialize' do
    it 'creates a station with name' do
      expect(station.name).not_to eq nil
    end
    it 'creates a station with zone attribute' do
      expect(station.zone).to eq 3
    end
  end
end
