# To hold data about the prospector
class Prospector
  def initialize(id, cur_location)
    @id = id
    @cur_location = cur_location
    @gold = 0
    @silver = 0
  end

  attr_reader :id

  attr_reader :cur_location

  attr_reader :gold

  attr_reader :silver
end