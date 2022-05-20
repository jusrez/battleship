class Board
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

	def valid_placement?(ship, coordinates)
		coordinate_letters = coordinates.map {|coordinate| coordinate[0].ord}
		coordinate_numbers = coordinates.map {|coordinate| coordinate[1].to_i}

		if ship.length == coordinates.count
			if coordinate_letters.uniq.size == 1 && coordinate_numbers.each_cons(2).all? {|x,y| y == x + 1}
				true
			elsif coordinate_numbers.uniq.size == 1 && coordinate_letters.each_cons(2).all? {|x,y| y == x + 1}
				true
			else
				false
			end
		else
			false

		end

	end

end
