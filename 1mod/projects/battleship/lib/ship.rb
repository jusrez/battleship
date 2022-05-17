class Ship

attr_reader :name, :length, :number_of_hits

  def initialize(name, length)
    @name = name
    @length = length
    @number_of_hits = []
  end

  def health
    length - number_of_hits.count
  end

  def sunk?
    health < 1
  end

  def hit
    number_of_hits << "hit!"
  end
end
