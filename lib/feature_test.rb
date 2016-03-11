require_relative 'oystercard'
require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

p station1 = Station.new('holborn')
p station2 = Station.new('heathrow_terminals')
p station3 = Station.new('arsenal')

p card = Oystercard.new
card.top_up(50)
card.touch_in(station1)
card.touch_in(station1)
p card.balance
card.touch_out(station3)
p card.balance
card.touch_in(station2)
card.touch_out(station1)
puts card.view_history
p card
p card.balance
card.touch_out(station1)
p card
p card.balance
