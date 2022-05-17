class Ship

attr_reader :name, :length, :number_of_hits

  def initialize(name, length)
    @name = name
    @length = length
    @number_of_hits = 0
  end

  def health
    length - @number_of_hits
  end

  def sunk?
    health < 1
  end

  def hit
    @number_of_hits += 1
  end
end
