class Board
	attr_reader :cells

	def initialize
	@cells = {
 "A1" => Cell.new("A1"),
 "A2" => Cell.new("A2"),
 "A3" => Cell.new("A3"),
 "A4" => Cell.new("A4"),
 "B1" => Cell.new("B1"),
 "B2" => Cell.new("B2"),
 "B3" => Cell.new("B3"),
 "B4" => Cell.new("B4"),
 "C1" => Cell.new("C1"),
 "C2" => Cell.new("C2"),
 "C3" => Cell.new("C3"),
 "C4" => Cell.new("C4"),
 "D1" => Cell.new("D1"),
 "D2" => Cell.new("D2"),
 "D3" => Cell.new("D3"),
 "D4" => Cell.new("D4")
	}
	end

  def valid_coordinate?(coordinate)
    cells.include?(coordinate)
  end

	def valid_placement?(ship, coordinates)
		coordinate_letters = coordinates.map {|coordinate| coordinate[0].ord}
		coordinate_numbers = coordinates.map {|coordinate| coordinate[1].to_i}

		if ship.length == coordinates.count && coordinates.all? {|coordinate| cells[coordinate].empty?}
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

	def place(ship, coordinates)
		coordinates.map {|coordinate| cells[coordinate].place_ship(ship)}
	end

	def render(reveal_ship = false)
	row_1 = "  1 2 3 4 \n"
	row_2 = "A #{cells["A1"].render(reveal_ship)} #{cells["A2"].render(reveal_ship)} #{cells["A3"].render(reveal_ship)} #{cells["A4"].render(reveal_ship)} \n"
	row_3 = "B #{cells["B1"].render(reveal_ship)} #{cells["B2"].render(reveal_ship)} #{cells["B3"].render(reveal_ship)} #{cells["B4"].render(reveal_ship)} \n"
	row_4 = "C #{cells["C1"].render(reveal_ship)} #{cells["C2"].render(reveal_ship)} #{cells["C3"].render(reveal_ship)} #{cells["C4"].render(reveal_ship)} \n"
	row_5 = "D #{cells["D1"].render(reveal_ship)} #{cells["D2"].render(reveal_ship)} #{cells["D3"].render(reveal_ship)} #{cells["D4"].render(reveal_ship)} \n"

	return row_1.concat(row_2, row_3, row_4, row_5)
	end


end
