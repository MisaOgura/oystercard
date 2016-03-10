require_relative 'oystercard'
require_relative 'journey'
require_relative 'station'

p station1 = Station.new('holborn')
p station2 = Station.new('heathrow_terminals')
p station3 = Station.new('arsenal')

p journey1 = Journey.new
journey1.start(station1)
p journey1
journey1.finish(station2)
p journey1
p journey1.fare

journey1.start(station3)
p journey1
p journey1.fare
