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
	# 	# if (ship.length == coordinates.count) == false
	# 	# 	return false
	# 	# elsif (ship.length == coordinates.count) == true
	# 	# 	grid = cells.keys
	# 	# 	coordinate_container = [coordinates]
	# 	# 	coordinate_set = []
	# 	# 	grid.each_cons(ship.length) do |set|
	# 	# 		coordinate_set << set
	# 	# 	end
	# 	# 	require "pry"; binding.pry
	# 	# 	if (coordinate_container - coordinate_set).empty? == false
	# 	# 		return false
	# 	# 	elsif (coordinate_container - coordinate_set).empty? == true
	# 	# 		return true
	# 	# 	end
	#
	# 	end
	#
	# end

end
