class Cell
	attr_reader :coordinate, :ship

	def initialize(coordinate)
		@coordinate = coordinate
		@ship = ship
		@fired_upon = 0
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
		if @fired_upon >= 1
			true
		elsif @fired_upon == 0
			false
		end
	end

	def fire_upon
		if empty? == false && @fired_upon == 0
			ship.hit
			@fired_upon += 1
		elsif empty? == true && @fired_upon == 0
			@fired_upon += 1
		end
	end

	def render(reveal_ship = false)
		if fired_upon? == false && reveal_ship == true && empty? == false
			"S"
		elsif fired_upon? == true && empty? == true
			"M"
		elsif fired_upon? == true && ship.sunk? == true
			"X"
		elsif fired_upon? == true && empty? == false
		  "H"
		elsif fired_upon? == false
			"."
		end
	end
end
