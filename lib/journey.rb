class Journey

  attr_reader :complete, :history

  def initialize
    @complete = true
    @history = {entry_station: [],
                exit_station: []}
  end

  def complete?
    @complete
  end

  def start_journey(entry_station)
    @history[:entry_station] << entry_station
    @complete = false
  end

  def end_journey(exit_station)
    @history[:exit_station] << exit_station
    @complete = true
  end

end
