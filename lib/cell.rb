class Cell
	attr_reader :coordinate, :ship

	def initialize(coordinate)
		@coordinate = coordinate
		@ship = ship
	end

	def empty?
		if @ship == nil
			true
		else
			false
		end
	end

	def place_ship(ship_type)
		@ship ||= ship_type
	end

	def fired_upon?
		ship.number_of_hits > 0
	end

	def fire_upon
		if empty? == false
			ship.hit
		end
	end

end
