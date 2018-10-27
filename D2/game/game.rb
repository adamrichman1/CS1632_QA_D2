require_relative 'location.rb'

# Control game flow
class Game

  def play
    init_state = build_graph
    travel(0, init_state)
  end

  def build_graph
    sutter_creek = Location.new("Sutter Creek", 0, 2)
    coloma = Location.new("Coloma", 0, 3)
    angels_camp = Location.new("Angels Camp", 0, 4)
    nevada_city = Location.new("Nevada City", 0, 5)
    virginia_city = Location.new("Virigina City", 3, 3)
    midas = Location.new("Midas", 5, 0)
    el_dorado_cn = Location.new("El Dorado Cn", 10, 0)

    sutter_creek.add_edge_cities([coloma, angels_camp])
    coloma.add_edge_cities([sutter_creek, virginia_city])
    angels_camp.add_edge_cities([nevada_city, sutter_creek, virginia_city])
    nevada_city.add_edge_cities([angels_camp])
    virginia_city.add_edge_cities([angels_camp,  coloma, midas, el_dorado_cn])
    midas.add_edge_cities([el_dorado_cn, virginia_city])
    el_dorado_cn.add_edge_cities([midas, virginia_city])

    # Return initial state
    sutter_creek
  end

  def travel(iteration, cur_state)
    if iteration == 5

    end
    travel(iteration + 1, get_next_state(cur_state))
  end

  def mine(cur_state)

  end

  def get_next_state(cur_state)

  end
end