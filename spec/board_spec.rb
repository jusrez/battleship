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

end
