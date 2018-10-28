require_relative 'location.rb'
# Control game flow
class Game
  def initialize(seed, num_prospectors)
    @num_prospectors = num_prospectors
    @rng = Random(seed)
  end

  def play
    init_state = build_graph
    travel(0, init_state, 0, 0)
  end

  def build_graph
    sutter_creek = Location.new('Sutter Creek', 0, 2)
    coloma = Location.new('Coloma', 0, 3)
    angels_camp = Location.new('Angels Camp', 0, 4)
    nevada_city = Location.new('Nevada City', 0, 5)
    virginia_city = Location.new('Virgina City', 3, 3)
    midas = Location.new('Midas', 5, 0)
    el_dorado_cn = Location.new('El Dorado Cn', 10, 0)

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

  def travel(iteration, cur_state, cur_silver, cur_gold)
    # Base case iteration == 5
    [cur_silver, cur_gold] if iteration == 5

    mining_results = mine(iteration, cur_state, 0, 0)
    cur_silver += mining_results[0]
    cur_gold += mining_results[1]
    travel(iteration + 1, get_next_state(cur_state), cur_silver, cur_gold)
  end

  def mine(iteration, cur_state, cur_silver, cur_gold)
    # Mine and update values
    silver = get_random_number(0, cur_state.max_silver)
    gold = get_random_number(0, cur_state.max_gold)
    cur_silver += silver
    cur_gold += gold

    # Base case = silver == 0 & gold == 0
    if iteration < 3
      [cur_silver, cur_gold] if silver == 0 && gold == 0
    elsif iteration < 5
      [cur_silver, cur_gold] if silver >= 3 && gold >= 2
    else raise Exception('>>> Illegal value for iteration: ' + iteration + ' <<<')
    end

    # Recursive case
    mine(iteration, cur_state, cur_silver, cur_gold)
  end

  def get_next_state(cur_state)
    cur_state[get_random_number(0, cur_state.edge_cities.length - 1)]
  end

  def get_random_number(min, max)
    @rng.rand(min, max)
  end
end