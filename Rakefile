require_relative './config/environment'

desc 'Print a grid'
task :grid do
  game = GameLoop.new
  game.run
end

desc 'Print a big grid'
task :biggrid do
  game = GameLoop.new(height: 16, width: 40)
  game.run
end
