require 'station'

describe Station do
subject(:station) { described_class.new("Shoreditch", 1) }

  describe '#initialize' do
    it '1.0 creates a station with zone' do
      expect(station.zone).to eq 1
    end

    it '1.1 creates a station with a station name' do
      expect(station.name).to eq "Shoreditch"
    end
  end
end
