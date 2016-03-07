require 'oystercard'

describe Oystercard do
subject(:card) { described_class.new }
  it 'has a balance' do
    expect(subject.check_balance).to eq Oystercard::DEFAULT_BALANCE
  end
end
