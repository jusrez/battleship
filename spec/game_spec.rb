require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Game do

	it 'exists' do
	 game = Game.new
	 expect(game).to be_instance_of(Game)
	 expect(game.computer_cruiser).to be_instance_of(Ship)
	 expect(game.computer_submarine).to be_instance_of(Ship)
	 expect(game.player_cruiser).to be_instance_of(Ship)
	 expect(game.player_submarine).to be_instance_of(Ship)
	end

	it 'starts with unsunk fleets' do
		game = Game.new
		expect(game.computer_fleet_sunk?).to be(false)
		expect(game.player_fleet_sunk?).to be(false)
	end

	it 'places a computer submarine' do
		game = Game.new
		expect(game.submarine_computer.empty?).to eq(true)
		game.computer_place_submarine
		expect(game.submarine_computer.count).to eq(2)
	end

	it 'places a computer cruiser' do
		game = Game.new
		expect(game.cruiser_computer.empty?).to eq(true)
		game.computer_place_cruiser
		expect(game.cruiser_computer.count).to eq(3)
	end

end
