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

  def city_name
    @city_name
  end

  def max_silver
    @max_silver
  end

  def max_gold
    @max_gold
  end

  def edge_cities
    @edge_cities
  end

end