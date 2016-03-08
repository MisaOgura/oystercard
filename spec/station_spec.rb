require 'station'

describe Station do
  list = Station::LIST

subject(:station) { described_class.new('Turnpike Lane') }

  describe '#initialize' do
    it 'creates a station with zone given a station name' do
      name = list.keys.sample
      station = described_class.new(name.to_s)
      expect(station.zone).to eq list[name]
    end
  end
end
