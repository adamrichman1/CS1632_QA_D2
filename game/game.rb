require_relative 'location.rb'
# Control game flow
class Game
  def initialize(seed, num_prospectors)
    @num_prospectors = num_prospectors
    @rng = Random.new(seed)
  end

  def play
    prospector_iteration = 1
    until prospector_iteration > @num_prospectors
      puts '*-*-* Prospector #' + prospector_iteration.to_s + ' *-*-*'
      init_state = build_graph
      print_game_results(prospector_iteration, travel(1, init_state, 0, 0))
      prospector_iteration += 1
    end
  end

  def build_graph
    # Create locations
    sutter_creek = Location.new('Sutter Creek', 0, 2)
    coloma = Location.new('Coloma', 0, 3)
    angels_camp = Location.new('Angels Camp', 0, 4)
    nevada_city = Location.new('Nevada City', 0, 5)
    virginia_city = Location.new('Virgina City', 3, 3)
    midas = Location.new('Midas', 5, 0)
    el_dorado_cn = Location.new('El Dorado Cn', 10, 0)

    # Add edges
    sutter_creek.add_edge_cities([coloma, angels_camp])
    coloma.add_edge_cities([sutter_creek, virginia_city])
    angels_camp.add_edge_cities([nevada_city, sutter_creek, virginia_city])
    nevada_city.add_edge_cities([angels_camp])
    virginia_city.add_edge_cities([angels_camp, coloma, midas, el_dorado_cn])
    midas.add_edge_cities([el_dorado_cn, virginia_city])
    el_dorado_cn.add_edge_cities([midas, virginia_city])

    # Return initial state
    sutter_creek
  end

  def travel(iteration, cur_state, cur_silver, cur_gold)
    # Base case iteration == 6
    return [cur_silver, cur_gold] if iteration == 6

    puts 'Iteration ' + iteration.to_s + ': Traveling to ' + cur_state.city_name + ' with ' + cur_silver.to_s +
             ' oz. in Silver & ' + cur_gold.to_s + ' oz. in Gold'

    mining_results = mine(iteration, cur_state, 0, 0)
    cur_silver += mining_results[0]
    cur_gold += mining_results[1]
    travel(iteration + 1, get_next_state(cur_state), cur_silver, cur_gold)
  end

  def mine(iteration, cur_state, cur_silver, cur_gold)
    while true
      # Mine and update values
      silver = get_random_number(0, cur_state.max_silver)
      gold = get_random_number(0, cur_state.max_gold)
      cur_silver += silver
      cur_gold += gold

      # Base case = silver == 0 & gold == 0
      if iteration <= 3 && silver.zero? && gold.zero?
        return print_mining_results(cur_silver, cur_gold)
      elsif iteration <= 5 && silver < 3 && gold < 2
        return print_mining_results(cur_silver, cur_gold)
      end
    end
  end

  def get_next_state(cur_state)
    cur_state.edge_cities[get_random_number(0, cur_state.edge_cities.length - 1)]
  end

  def get_random_number(min, max)
    @rng.rand(min..max)
  end

  def print_mining_results(silver, gold)
    puts "\tMining Results"
    if silver.zero? && gold.zero?
      puts "\tNo precious metals were found!"
    elsif gold.zero?
      puts "\tSilver found: " + silver.to_s + get_ounces_string(silver)
    elsif silver.zero?
      puts "\tGold found: " + gold.to_s + get_ounces_string(gold)
    else
      puts "\tSilver found: " + silver.to_s + get_ounces_string(silver)
      puts "\tGold found: " + gold.to_s + get_ounces_string(gold)
    end
    [silver, gold]
  end

  def print_game_results(prospector_iteration, game_results)
    silver = game_results[0]
    gold = game_results[1]
    puts '******** Prospector #' + prospector_iteration.to_s + ' Results ********'
    puts "\nTotal Silver Found: " + silver.to_s + get_ounces_string(silver)
    puts 'Total Gold Found: ' + gold.to_s + get_ounces_string(gold)
    if (silver * 1.31).to_s.split('.')[1].length == 1
      suffix = '0'
    else
      suffix = ''
    end
    puts "Silver Value: $" + (silver * 1.31).to_s + suffix
    if (gold * 20.67).to_s.split('.')[1].length == 1
      suffix = '0'
    else
      suffix = ''
    end
    puts "Gold Value: $" + (gold * 20.67).to_s + suffix + "\n"
  end

  def get_ounces_string(num_ounces)
    if num_ounces == 1
      ' ounce'
    else
      ' ounces'
    end
  end
end