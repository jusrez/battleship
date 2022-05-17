require './lib/ship'

RSpec.describe Ship do

  cruiser = Ship.new("Cruiser", 3)

  it 'has name' do
    expect(cruiser.name).to eq("Cruiser")
  end

  it 'has length' do
    expect(cruiser.length).to eq(3)
  end

  it 'has health' do
    expect(cruiser.health).to eq(3)
  end

  it 'has sunk?' do
    expect(cruiser.sunk?).to eq(false)
  end

  it 'has reduced health after hit' do
    cruiser.hit

    expect(cruiser.health).to eq(2)

    cruiser.hit

    expect(cruiser.health).to eq(1)
  end

  it 'has sunk' do
    expect(cruiser.sunk?).to eq(false)

    cruiser.hit

    expect(cruiser.sunk?).to eq(true)
  end
end
