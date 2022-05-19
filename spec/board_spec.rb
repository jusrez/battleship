require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  it 'is a hash' do
    board = Board.new
    expect(board.cells).to be_a(Hash)
  end

  it 'has 16 key/value pairs' do
    board = Board.new
    expect(board.cells.count).to eq(16)
  end

  it 'has keys that point to cell objects' do
    board = Board.new
    expect(board.cells.values).to be_a(Object)
  end

  it 'has valid coordinates' do
    board = Board.new
    expect(board.valid_coordinate?("A1")).to eq(true)

    expect(board.valid_coordinate?("D4")).to eq(true)

    expect(board.valid_coordinate?("A5")).to eq(false)

    expect(board.valid_coordinate?("E1")).to eq(false)

    expect(board.valid_coordinate?("A22")).to eq(false)
  end

	it 'validates placement by checking if ship coordinates are enough for the ships length' do
		board = Board.new
		cruiser = Ship.new("Cruiser", 3)
		submarine = Ship.new("Submarine", 2)

		expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
		expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
	end

	it 'validates placement by checking if coordinates are consecutive' do
		board = Board.new
		cruiser = Ship.new("Cruiser", 3)
		submarine = Ship.new("Submarine", 2)

		expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
		expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
		expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
		expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
	end

	it 'validates placement by checking if coordinates are diagonal' do
		board = Board.new
		cruiser = Ship.new("Cruiser", 3)
		submarine = Ship.new("Submarine", 2)

		expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
		expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
	end

	it 'validates placement is correct' do
		board = Board.new
		cruiser = Ship.new("Cruiser", 3)
		submarine = Ship.new("Submarine", 2)

		expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
		expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
	end

end
