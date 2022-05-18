class Board
  # def initialize(rows, columns)
  #   # @rows = rows
  #   # @columns = columns
  # end

  def cells
    letters = ('A'..'D')
    numbers = ('1'..'4')
    grid_array = []
    letters.each do |letter|
      numbers.each do |number|
        grid_array << "#{letter}#{number}"
      end
    end
    grid_hash = {}
    grid_array.each do |grid|
      grid_hash[grid] = Cell.new(grid)
    end
    grid_hash
  end

  def valid_coordinate?(coordinate)
    cells.include?(coordinate)
  end

end
