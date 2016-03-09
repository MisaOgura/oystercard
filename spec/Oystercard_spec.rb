# in spec/Oystercard_spec.rb
require 'oystercard'

describe Oystercard do

  min_fare = Oystercard::MIN_FARE
  penalty_fare = Oystercard::PENALTY_FARE

  subject(:card) { described_class.new }
  let(:station) { double(:station)}
  let(:station2) { double(:station)}

  context 'Oystercard balance' do
    describe '#card_balance' do
      it "should show the card's initial balance" do
        expect(card.balance).to eq 0
      end
    end

    describe '#top_up' do
      it "should top up the card" do
        expect{ card.top_up 10 }.to change{ card.balance }.by 10
      end
      it 'should raise an error if new balance would be greater than £90' do
        max_balance = Oystercard::CARD_LIMIT
        card.top_up(max_balance)
        expect{ card.top_up 1 }.to raise_error "Card balance may not exceed £#{max_balance}"
      end
    end
  end

  context 'Oystercard actions' do

    describe '#touch_in' do
      it 'should raise an error if balance is below mininum amount' do
        expect { card.touch_in(station) }.to raise_error "Card balance is too low."
      end
      # it 'should create a journey object' do
      #   card.top_up(5)
      #   card.touch_in(station)
      #   expect(card.journey_log[-1]).to be_an_instance_of Journey
      # end
      # it 'should check whether previous journey was complete' do
      #   card.top_up(10)
      #   card.touch_in(station)
      #   card.touch_in(station)
      #   expect(card.previous_journey_complete?).to eq false
      # end
      it 'should deduct penalty fare for invalid touch in' do
        card.top_up(10)
        card.touch_in(station)
        p @log.show_last_journey
        expect{card.touch_in(station)}.to change{card.balance}. by -penalty_fare
      end
    end

    describe '#touch_out' do
      it 'should charge penalty fare for invalid touch out' do
        expect{ card.touch_out(station) }.to change{ card.balance }.by -6
      end
      it 'should deduct card balance by minimum amount' do
        card.top_up(5)
        card.touch_in(station)
        expect{ card.touch_out(station) }.to change{ card.balance }.by -1
      end
    end

    describe '#previous_journey_complete?' do
      it 'should return true for complete previous journey' do
        card.top_up(5)
        card.touch_in(station)
        card.touch_out(station)
        expect(card.previous_journey_complete?).to eq true
      end
      it 'should return false for incomplete previous journey' do
        card.top_up(5)
        card.touch_out(station)
        expect(card.previous_journey_complete?).to eq false
      end
    end

    context 'Oystercard journeys' do
      describe 'should store journey history' do
        it 'should return a hash' do
          expect(card.journey_log).to be_a(Array)
        end
      end
    end
  end
end
