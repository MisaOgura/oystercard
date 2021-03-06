require 'oystercard'

describe Oystercard do
subject(:card) { described_class.new }


  describe '#check_balance' do
    it 'has a balance' do
      expect(subject.check_balance).to eq Oystercard::DEFAULT_BALANCE
    end
  end

  describe '#topup' do
    it 'adds money to the balance' do
      amount = Random.rand(5..10)
      expect(subject.topup(amount)).to eq (Oystercard::DEFAULT_BALANCE + amount)
    end

    context 'when maximum balance exceeded' do
      it 'raises an error' do
        amount = Random.rand(100..200)
        message = "maximum balance is £#{Oystercard::MAXIMUM}"
        expect{subject.topup(amount)}.to raise_error message
      end
    end
  end

  describe '#deduct' do
    it 'deduct money from the card' do
      init_balance = subject.check_balance
      amount = Random.rand(1..5)
      subject.deduct(amount)
      expect(subject.check_balance).to eq (init_balance - amount)
    end

    context 'when balance becomes below 0' do
      it 'raise an error' do
        init_balance = subject.check_balance
        amount = Random.rand(6..10)
        message = 'balance below zero'
        expect{subject.deduct(amount)}.to raise_error message
      end
    end
  end

  describe '#touch_in' do

    it 'raise an error when balance below £1' do
      card.deduct(5)
      message = 'need minimum £1 to touch-in'
      expect{card.touch_in}.to raise_error message
    end

    it 'changes in_journey to true' do
      status = subject.in_journey
      expect(subject.touch_in).not_to eq status
    end
  end

  describe '#touch_out' do
    it 'changes in_journey to false' do
      status = subject.in_journey
      expect(subject.touch_out).not_to eq status
    end
  end

end
