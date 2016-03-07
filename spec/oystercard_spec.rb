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
  end

end
