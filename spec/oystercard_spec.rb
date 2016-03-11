require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new}
  let(:station) { double :station }
  let(:journey) { double :journey }

  describe '#balance' do
    it 'checks that new card has a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    before do
      card.top_up(20)
    end

    it 'it adds 20 to balance' do
      expect(card.balance).to eq 20
    end

    it 'raises an error if balance exceeds limit' do
      message = "Error, balance exceeds £#{Oystercard::MAX_LIMIT}!"
      expect{ card.top_up(100) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'raises error when balance insufficient' do
      message = "Error insufficient funds"
      expect{ subject.touch_in(station) }.to raise_error message
    end

    it 'charges a penatly if no touch_out' do
      card.top_up(20)
      card.touch_in(station)
      expect{card.touch_in(station)}.to change {card.balance}.by JOURNEY::PENALTY_FARE
    end

    xit 'returns beginning of current journey' do
      card.top_up(20)
      expect(journey).to receive(:begin_journey).with('Hoxton')
      card.touch_in('Hoxton')
    end
  end

  describe '#touch_out' do
    xit 'deducts fare from balance' do
      card.top_up(20)
      card.touch_in(station)
      expect{ card.touch_out(station) }.to change{ card.balance }.by -Oystercard::MIN_FARE
    end
  end

end
