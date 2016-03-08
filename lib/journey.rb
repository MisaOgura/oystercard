class Journey

  attr_reader :complete

  def initialize
    @complete = true
  end

  def complete?
    @complete
  end

  def start_journey
    @complete = false
  end

  def end_journey
    @complete = true
  end

end
