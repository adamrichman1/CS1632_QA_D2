# Class to hold location data
class Location
  def initialize(city_name, max_silver, max_gold)
    @city_name = city_name
    @max_silver = max_silver
    @max_gold = max_gold
    @edge_cities = edge_cities
  end

  def add_edge_cities(edge_cities)
    @edge_cities = edge_cities
  end

  attr_reader :city_name

  attr_reader :max_silver

  attr_reader :max_gold

  attr_reader :edge_cities
end