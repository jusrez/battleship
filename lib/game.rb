class Game
	attr_reader :computer_board,
							:player_board,
							:computer_cruiser,
							:computer_submarine,
							:player_cruiser,
							:player_submarine

	def initialize
		@computer_board = Board.new
		@player_board = Board.new
		@computer_cruiser = Ship.new("Cruiser", 3)
		@computer_submarine = Ship.new("Submarine", 2)
		@player_cruiser = Ship.new("Cruiser", 3)
		@player_submarine = Ship.new("Submarine", 2)
	end

	def main_menu
		puts "Welcome to BATTLESHIP"
		puts "Enter p to play. Enter q to quit."
		answer = gets.chomp.downcase
		if answer == "p"
			return computer_setup
		elsif answer == "q"
			puts "Later loser ✌️"
		else
			puts "Wrong input. Try again."
			return main_menu
		end
	end

	def computer_setup
		coordinates = computer_board.cells.keys
		cruiser_computer = []
		submarine_computer = []

		while computer_board.valid_placement?(computer_cruiser, cruiser_computer) == false
			cruiser_computer << coordinates.sample(3)
			cruiser_computer.flatten!
			if computer_board.valid_placement?(computer_cruiser, cruiser_computer) == false
				cruiser_computer.clear
			else
				break
			end
		end

		while computer_board.valid_placement?(computer_submarine, submarine_computer) == false
			submarine_computer << coordinates.sample(2)
			submarine_computer.flatten!
			if computer_board.valid_placement?(computer_submarine, submarine_computer) == false
				submarine_computer.clear
			else
				break
			end
		end

		computer_board.place(computer_cruiser, cruiser_computer)
		computer_board.place(computer_submarine, submarine_computer)
		puts "I have laid out my ships on the grid."
		puts "You now need to lay out your two ships."

		return player_setup
	end

	def player_setup
		cruiser_player = []
		submarine_player = []
		cruiser_placed = 0
		submarine_placed = 0
		puts "The Cruiser is three units long and the Submarine is two units long."
		print player_board.render
		puts "Enter the squares for the Cruiser (3 spaces): "

		while cruiser_placed == 0
			cruiser_player << gets.upcase.split
			cruiser_player.flatten!
			if cruiser_player.all? {|coordinate| player_board.valid_coordinate?(coordinate)}
					if player_board.valid_placement?(player_cruiser, cruiser_player)
						player_board.place(player_cruiser, cruiser_player)
						cruiser_placed += 1
					else
						cruiser_player.clear
						puts "Those are invalid coordinates. Please try again:"
					end
			else
					cruiser_player.clear
					puts "Those are invalid coordinates. Please try again:"
			end
		end

		print player_board.render(true)
		puts "Enter the squares for the Submarine (2 spaces): "

		while submarine_placed == 0
			submarine_player << gets.upcase.split
			submarine_player.flatten!
			if submarine_player.all? {|coordinate| player_board.valid_coordinate?(coordinate)}
					if player_board.valid_placement?(player_submarine, submarine_player)
						player_board.place(player_submarine, submarine_player)
						submarine_placed += 1
					else
						submarine_player.clear
						puts "Those are invalid coordinates. Please try again:"
					end
			else
					submarine_player.clear
					puts "Those are invalid coordinates. Please try again:"
			end
		end

		puts "=============COMPUTER BOARD============="
		print computer_board.render
		puts "==============PLAYER BOARD=============="
		print player_board.render(true)

	end

	def computer_turn
		coordinates = computer_board.cells.keys
		computer_coordinate = coordinates.sample
		puts "The computer has taken a shot at coordinate: #{computer_coordinate}"
		player_board.fire_upon(computer_coordinate)
		if player_board.render_indiv(computer_coordinate) == "M"
			puts "The computer's shot was a miss!"
		elsif player_board.render_indiv(computer_coordinate) == "H"
			puts "The computer's shot was a hit!"
		elsif player_board.render_indiv(computer_coordinate) == "X"
			puts "The computer's shot was a hit and your vessel has sunk!"
		end

		puts "=============COMPUTER BOARD============="
		print computer_board.render
		puts "==============PLAYER BOARD=============="
		print player_board.render(true)
		
		player_turn
	end

	def player_turn
		puts "It's your turn! Enter the coordinate for your shot:"
		coordinate = gets.chomp.upcase
		computer_board.fire_upon(coordinate)
		if computer_board.render_indiv(coordinate) == "M"
			puts "Your shot was a miss!"
		elsif computer_board.render_indiv(coordinate) == "H"
			puts "Your shot was a hit!"
		elsif computer_board.render_indiv(coordinate) == "X"
			puts "Your shot was a hit and the computer's vessel has sunk!"
		end

		puts "=============COMPUTER BOARD============="
		print computer_board.render
		puts "==============PLAYER BOARD=============="
		print player_board.render(true)

		computer_turn
	end



end
