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

  it 'places ships' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    expect(cell_3.ship).to eq(cell_2.ship)
    # => true
  end

  xit 'makes sure ships do not overlap' do
    require './lib/board'
    require './lib/ship'

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    submarine = Ship.new("Submarine", 2)

    board.valid_placement?(submarine, ["A1", "B1"])
    # => false
  end

  xit 'renders the board' do
    require './lib/board'
    require './lib/ship'

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    board.render
    # => "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    board.render(true)
    # => "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
  end

end
