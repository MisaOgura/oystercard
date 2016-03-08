require 'station'

describe Station do

subject(:station) { described_class.new }

  describe '#initialize' do
    it 'creates a station with name' do
      expect(station.name).not_to be eq nil
    end
    it 'creates a station with zone attribute' do
      expect(station.zone).not_to be eq nil
    end


  end
end
