require_relative 'game/game.rb'

def check_args(args)
  args.count == 1 && args[0].to_i > 0
rescue StandardError
  false
end

valid_args = check_args ARGV

if valid_args
  seed = ARGV[0].to_i
  num_prospectors = ARGV[1].to_i
  g = Game.new seed, num_prospectors
  g.play
else
  puts 'Invalid arguments'
  exit 1
end