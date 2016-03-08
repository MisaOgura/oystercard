require 'journey'

describe Journey do

  subject(:journey) { described_class.new }

  describe '#initialize' do
    it 'creats a journey with complete attribute as true' do
      expect(journey.complete?).to eq true
    end
  end

  describe '#start_journey' do
    it 'starts a journey' do
      journey.start_journey
      expect(journey.complete?).to eq false
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      journey.end_journey
      expect(journey.complete?).to eq true
    end
  end

end
