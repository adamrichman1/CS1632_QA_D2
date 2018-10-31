require 'minitest/autorun'

require_relative 'game'
require_relative 'location'
require_relative 'prospector'

# Main Testing Class
class GameTest < Minitest::Test
  def setup
    @game = Game.new(500, 10)
  end

  # UNIT TESTS FOR METHOD get_random_number(min, max)
  # Equivalence classes:
  # min <= max, returns num between min and max
  # min > max, throws error

  # Given a valid range, a random number in that range is returned
  def test_random_number_generation
    rand = @game.get_random_number(0, 10)
    assert rand <= 10 && rand >= 0
  end

  # If a bad range is provided, an ArgumentError is raised
  # EDGE CASE
  def test_random_number_bad_range
    assert_raises(ArgumentError) do
      @game.get_random_number(1, 0)
    end
  end

  # UNIT TESTS FOR METHOD get_ounces_string(num_ounces)
  # Equivalence classes:
  # num_ounces == 1, returns ' ounce'
  # num_ounces != 1, returns ' ounces'

  # If only 1 ounce, returns singular ounce
  # EDGE CASE
  def test_get_ounce_string_singular
    ret_string = @game.get_ounces_string(1)
    assert_equal(' ounce', ret_string)
  end

  # If not 1 ounce, returns plural ounces
  def test_get_ounce_string_plural
    ret_string = @game.get_ounces_string(2)
    assert_equal(' ounces', ret_string)
  end

  # UNIT TESTS FOR METHOD get_next_state(cur_state)

  # Ensures the next state is different from the current state
  def test_next_state_is_different
    init_state = @game.build_graph
    refute_equal(init_state, @game.get_next_state(init_state))
  end

  # UNIT TESTS FOR METHOD mine(iteration, cur_state, cur_silver, cur_gold)
  # Equivalence classes:
  # iteration <= 3 && silver.zero? && gold.zero?, return cur_silver, cur_gold
  # iteration <= 5 && silver < 3 && gold < 2, return cur_silver, cur_gold
  # iteration > 5, raise exception

  # Tests that, given first equivalence class, the array is returned
  def test_mine_iteration_three
    fake_state = Minitest::Mock.new
    def fake_state.max_silver
      0
    end

    def fake_state.max_gold
      0
    end

    assert_equal([0, 0], @game.mine(3, fake_state, 0, 0))
  end

  # Tests that, given second equivalence class, the array is returned
  def test_mine_iteration_five
    fake_state = Minitest::Mock.new
    def fake_state.max_silver
      0
    end

    def fake_state.max_gold
      0
    end
    assert_equal([2, 1], @game.mine(5, fake_state, 2, 1))
  end

  # Tests that, given third equivalence class, an exception is raised
  # EDGE CASE
  def test_mine_iteration_six
    fake_state = Minitest::Mock.new
    def fake_state.max_silver
      0
    end

    def fake_state.max_gold
      0
    end
    assert_raises(Exception) do
      @game.mine(6, fake_state, 2, 1)
    end
  end

  # UNIT TESTS FOR METHOD travel(iteration, cur_state, cur_silver, cur_gold)
  # Equivalence classes:
  # At the 6th iteration, return [cur_silver, cur_gold]
  # Below 6 iterations, travel and mine recursively until 6, then return [cur_silver, cur_gold]

  # Return final silver and gold counts at 6th iteration
  def test_travel_iteration_six
    fake_state = Minitest::Mock.new
    assert_equal([8, 7], @game.travel(6, fake_state, 8, 7))
  end

  # Travel to 6th iteration from 5th iteration
  def test_travel_iteration_five
    fake_state = Minitest::Mock.new
    def fake_state.max_silver
      0
    end

    def fake_state.max_gold
      0
    end

    def fake_state.city_name
      'test1'
    end

    def fake_state.edge_cities
      [Location.new('test1', 0, 0)]
    end

    assert_equal([6, 2], @game.travel(5, fake_state, 6, 2))
  end

  # UNIT TESTS FOR METHOD play
  # Equivalence classes
  # play with a 'normal' number of prospectors
  # play with an invalid number of prospectors

  # Normal execution of play will not return anything, but no exceptions will be raised
  def test_play_normal
    assert_nil(@game.play)
  end

  # Execution with prospector set to 0, should raise Exception
  # EDGE CASE
  def test_play_zero
    assert_raises(Exception) do
      Game.new(500, 0).play
    end
  end

  # UNIT TESTS FOR METHOD print_mining_results(silver, gold)
  # Equivalence classes:
  # silver == 0 && gold == 0
  # silver != 0 && gold == 0
  # silver == 0 && gold != 0
  # silver 1= 0 && gold != 0

  # Test print statement when nothing has been mined
  def test_print_nil
    assert_output("\tMining Results\n\tNo precious metals were found!\n") do
      @game.print_mining_results(0, 0)
    end
  end

  # Test print statement when nothing has been mined
  def test_print_silver
    assert_output("\tMining Results\n\tSilver found: 5 ounces\n") do
      @game.print_mining_results(5, 0)
    end
  end

  # Test print statement when nothing has been mined
  def test_print_gold
    assert_output("\tMining Results\n\tGold found: 7 ounces\n") do
      @game.print_mining_results(0, 7)
    end
  end

  # Test print statement when nothing has been mined
  def test_print_silver_gold
    assert_output("\tMining Results\n\tSilver found: 6 ounces\n\tGold found: 2 ounces\n") do
      @game.print_mining_results(6, 2)
    end
  end

  # SILLY UNIT TESTS FOR CODE COVERAGE

  # Does the prospector initialize properly?
  def test_prospector_initializer
    test_prospector = Prospector.new(nil, nil)
    assert_nil(test_prospector.id)
    assert_nil(test_prospector.cur_location)
    assert_equal(0, test_prospector.silver)
    assert_equal(0, test_prospector.gold)
  end
end
