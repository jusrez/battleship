require './lib/ship'
#=> true

cruiser = Ship.new("Cruiser", 3)
#=> #<Ship:0x00007feb05112d10...>

it 'has name' do
  expect(cruiser.name).to eq("Cruiser")
  #=> "Cruiser"
end

it 'has length' do
  expect(cruiser.length).to eq(3)
  #=> 3
end

it 'has health' do
  expect(cruiser.health).to eq(3)
  #=> 3
end

it 'has sunk?' do
  expect(cruiser.sunk?).to eq(false)
  #=> false
end

it 'has reduced health after hit' do
  cruiser.hit

  expect(cruiser.health).to eq(2)
  #=> 2

  cruiser.hit

  expect(cruiser.health).to eq(1)
  #=> 1
end

it 'has sunk' do
  expect(cruiser.sunk?).to eq(false)
  #=> false

  cruiser.hit

  expect(cruiser.sunk?).to eq(true)
  #=> true
end
