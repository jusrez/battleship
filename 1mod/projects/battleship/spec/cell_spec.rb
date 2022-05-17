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
end
