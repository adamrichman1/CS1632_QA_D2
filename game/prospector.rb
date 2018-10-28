# To hold data about the prospector
class Prospector
  def initialize(id, cur_location)
    @id = id
    @cur_location = cur_location
    @gold = 0
    @silver = 0
  end

  def id
    @id
  end

  def cur_location
    @cur_location
  end

  def gold
    @gold
  end

  def silver
    @silver
  end
end