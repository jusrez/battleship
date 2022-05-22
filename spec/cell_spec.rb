require './lib/ship'
require './lib/cell'

RSpec.describe Cell do

	it 'exists' do
	 cell = Cell.new("B4")
	 expect(cell).to be_instance_of(Cell)
	end

	it 'confirms if coordinate method works' do
		cell = Cell.new("B4")
		expect(cell.coordinate).to eq("B4")
	end

	it 'confirms ship is not in cell' do
		cell = Cell.new("B4")
		expect(cell.ship).to eq(nil)
	end

	it 'confirms cell is empty' do
		cell = Cell.new("B4")
		expect(cell.empty?).to eq(true)
	end

	it 'confirms ship is placed in cell' do
		cell = Cell.new("B4")
		cruiser = Ship.new("Cruiser", 3)
		cell.place_ship(cruiser)

		expect(cell.ship).to eq(cruiser)

		expect(cell.empty?).to eq(false)
	end

	it 'takes damage when fired upon' do
		cell = Cell.new("B4")
		cruiser = Ship.new("Cruiser", 3)
		cell.place_ship(cruiser)

		expect(cell.fired_upon?).to eq(false)

		cell.fire_upon

		expect(cell.ship.health).to eq(2)

		expect(cell.fired_upon?).to eq(true)
	end

	it 'renders a cell that has not been fired upon' do
		cell_1 = Cell.new ("B4")
		cell_2 = Cell.new ("C3")

		expect(cell_1.render).to eq(".")

		expect(cell_2.render).to eq(".")
	end

	it 'renders a cell that shows a miss' do
		cell_1 = Cell.new ("B4")
		cell_1.fire_upon

		expect(cell_1.render).to eq("M")
	end

	it 'renders a cell that reveals a ship not fired upon' do
		cell_2 = Cell.new ("C3")
		cruiser = Ship.new("Cruiser", 3)
		cell_2.place_ship(cruiser)

		expect(cell_2.render(true)).to eq("S")
	end

	it 'renders a cell that shows a hit' do
		cruiser = Ship.new("Cruiser", 3)
		cell_2 = Cell.new ("C3")
		cell_2.place_ship(cruiser)

		cell_2.fire_upon

		expect(cell_2.render).to eq("H")
	end

	it 'renders a cell that shows a ship has been sunk' do
		cell = Cell.new("B4")
		cruiser = Ship.new("Cruiser", 3)
		cell_2 = Cell.new ("C3")
		cell_2.place_ship(cruiser)

		expect(cell_2.render).to eq(".")

		expect(cell_2.render(true)).to eq("S")

		cell_2.fire_upon

		expect(cell_2.render).to eq("H")

		expect(cruiser.sunk?).to eq(false)

	  cruiser.hit

		cruiser.hit

		expect(cruiser.sunk?).to eq(true)

		expect(cell_2.render).to eq("X")
	end

end
