require 'journey'

describe Journey do

  min_fare = Journey::MIN_FARE
  penalty_fare = Journey::PENALTY_FARE

  subject(:journey) { described_class.new }
  let(:entry_station) { double(:station)}
  let(:exit_station) { double(:station)}
  let(:invalid_journey) { double(:station, valid?: false, fare: penalty_fare)}

  describe '#initialize' do
    it 'creates a journey with complete attribute as true' do
      expect(journey.complete?).to eq true
    end
    it 'creates a hash with entry_station: []' do
      expect(journey.history[:entry_station]).to eq([])
    end
    it 'creates a hash with exit_station: []' do
      expect(journey.history[:exit_station]).to eq([])
    end
    it 'creates a journey with minimu fare as default' do
      expect(journey.fare).to eq(min_fare)
    end
    it 'creates a journey with a valid status' do
      expect(journey.valid).to eq(true)
    end
  end

  describe '#start_journey' do
    it 'calls touch_in_valid? to check if touch_in is valid' do
      expect(journey).to receive(:touch_in_valid?)
      journey.start_at(entry_station)
    end

    before(:each) do
      journey.start_at(entry_station)
    end
    it 'changes complete? status to false' do
      expect(journey.complete?).to eq(false)
    end
    it 'stores an entry_station to the history' do
      expect(journey.history[:entry_station]).to include(entry_station)
    end
  end

  describe '#end_journey' do
    it 'calls touch_out_valid? to check if touch_out is valid' do
      expect(journey).to receive(:touch_out_valid?)
      journey.end_at(exit_station)
    end

    before(:each) do
      journey.end_at(exit_station)
    end
    it 'ends a journey' do
      expect(journey.complete?).to eq(true)
    end
    it 'stores an exit_station to the history' do
      expect(journey.history[:exit_station]).to include(exit_station)
    end
  end

  describe '#touch_in_valid?' do
    it 'returns true for the first touch_in' do
      journey.start_at(entry_station)
      expect(journey.valid?).to eq(true)
    end
    it 'returns false when a touch_in is invalid' do
      2.times {journey.start_at(entry_station)}
      expect(journey.valid?).to eq(false)
    end
  end

  describe '#touch_out_valid?' do
    it 'returns false when a touch_out is invalid' do
      journey.end_at(exit_station)
      expect(journey.valid?).to eq(false)
    end
  end

  describe '#fare' do
    it 'charges a minimum fare on valid journeys' do
      expect(journey.fare).to eq(min_fare)
    end
    it 'charges a penalty fare on invalid journeys' do
      expect(invalid_journey.fare).to eq(penalty_fare)
    end
  end
end

# before touch_out => journey.history[:entry_station].count = journey.history[:exit_station].count + 1
# AND journey.complete? false

# before touch_in => journey.history[:entry_station].count = journey.history[:exit_station].count
# AND journey.complete? true

# complete can't be changed from false to false NOR true to true
