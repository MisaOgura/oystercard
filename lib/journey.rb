class Journey
  MIN_FARE = 2
  PENALTY_FARE = 6
  attr_reader :complete, :history, :fare, :valid

  def initialize
    @valid = true
    @fare = MIN_FARE
    @complete = true
    @history = {entry_station: [], exit_station: []}
  end

  def complete?
    @complete
  end

  def start_at(entry_station)
    touch_in_valid?
    @history[:entry_station] << entry_station
    @complete = false
  end

  def end_at(exit_station)
    touch_out_valid?
    @history[:exit_station] << exit_station
    @complete = true
  end

  def valid?
    @valid
  end

  def fare
    valid? ? MIN_FARE : PENALTY_FARE
  end

  private

  def touch_in_valid?
    @valid = true if @history[:entry_station].empty?
    @complete == false ? @valid = false : @valid = true
  end

  def touch_out_valid?
    @complete == true ? @valid = false : @valid = true
  end
end
