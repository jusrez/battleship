require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Game do

	it 'exists' do
	 game = Game.new

	 expect(game).to be_instance_of(Game)
	end

	it 'randomly places computers ships' do
		game = Game.new
		game.computer_setup

		expect(game.computer_board.cells.all? {|cell, cell_instance| cell_instance.empty?}).to eq(false)
	end

end
