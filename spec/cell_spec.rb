require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
	cell = Cell.new("B4")
	cruiser = Ship.new("Cruiser", 3)

	it 'exists' do
	 expect(cell).to be_instance_of(Cell)
	end

	it 'confirms if coordinate method works' do
		expect(cell.coordinate).to eq("B4")
	end

	it 'confirms ship is not in cell' do
		expect(cell.ship).to eq(nil)
	end

	it 'confirms cell is empty' do
		expect(cell.empty?).to eq(true)
	end

	it 'confirms ship is placed in cell' do
		cell.place_ship(cruiser)

		expect(cell.ship).to eq(cruiser)
		expect(cell.empty?).to eq(false)
	end

	it 'takes damage when fired upon' do
		cell.place_ship(cruiser)

		expect(cell.fired_upon?).to eq(false)

		cell.fire_upon

		expect(cell.ship.health).to eq(2)
		expect(cell.fired_upon?).to eq(true)
	end
end
