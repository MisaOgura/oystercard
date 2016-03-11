require 'journey'

describe Journey do
  let(:journey) { described_class.new }
  let(:current) {{ entry: nil, exit: nil}}
  let(:station) { double :station }
  let(:station2) { double :station2 }
  let(:current2) {{ entry: station, exit: station2}}
  let(:card) { double:card}

  it 'initializes with an empty current journey' do
    expect(journey.current).to eq current
  end

  it 'initializes with and empty journey log' do
    expect(journey.history).to be_empty
  end

  describe '#begin_journey' do
    it 'sets an entry station' do
      journey.begin_journey(station)
    expect(journey.current).not_to eq current
    end
  end

  describe '#end_journey' do
    it 'sets an exit station' do
      journey.begin_journey(station)
      journey.end_journey(station2)
      expect(journey.current).to eq current2
    end

    it 'records journey history' do
      journey.begin_journey(station)
      journey.end_journey(station2)
      expect(journey.history).to include current2
    end
  end

  describe '#fare' do
    xit 'charges minimum fare if current journey complete' do
      journey.begin_journey(station)
      journey.end_journey(station2)
      # expect(journey)
    end
  end
end