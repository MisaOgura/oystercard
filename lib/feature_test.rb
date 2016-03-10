require_relative 'journey'
require_relative 'oystercard'
require_relative 'journey_log'

station1 = Station.new('holborn', 6)
station2 = Station.new('heathrow terminals', 1)

p station1
p station2

log = JourneyLog.new

log.entry(station1)
log.exit(station2)
p log.journeys
p log.journeys.length
p log.journeys[-1].complete?
