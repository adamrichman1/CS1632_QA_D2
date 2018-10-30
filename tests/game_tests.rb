require 'minitest/autorun'
require_relative '../game/game.rb'
require_relative '../game/location.rb'

class GameTest < Minitest::Test
  def test_random_number_generation
    rand = Game::new(234, 1).get_random_number(0, 10)
    assert rand <= 10 && rand >= 0
  end

  def test_get_ounce_string_singular
    test_game = Game::new(234, 1)
    ret_string = test_game.get_ounces_string(1)
    assert_equal(' ounce', ret_string)
  end

  def test_get_ounce_string_plural
    test_game = Game::new(234, 1)
    ret_string = test_game.get_ounces_string(2)
    assert_equal(' ounces', ret_string)
  end

  def test_next_state_is_location
    test_game = Game::new(234, 1)
    init_state = test_game.build_graph
    assert_instance_of(Location, test_game.get_next_state(init_state))
  end

  def test_next_state_is_different
    test_game = Game::new(234, 1)
    init_state = test_game.build_graph
    refute_equal(init_state, test_game.get_next_state(init_state))
  end

  def mine_test
    test_game = Game::new(234, 1)
    init_state = test_game.build_graph
    assert_kind_of(Integer[], test_game.mine(0, init_state, 0, 0))
  end
end
