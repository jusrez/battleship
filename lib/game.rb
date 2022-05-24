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
		@computer_coordinates = computer_board.cells.keys
		@cruiser_computer = []
		@submarine_computer = []
		@cruiser_player = []
		@submarine_player = []
		@cruiser_placed = false
		@submarine_placed = false
	end

	def main_menu
		welcome_message
		answer = gets.chomp.downcase
		main_menu_input(answer)
	end

	def computer_setup
		page_break
		computer_place_cruiser
		computer_board.place(@computer_cruiser, @cruiser_computer)
		computer_place_submarine
		computer_board.place(@computer_submarine, @submarine_computer)
		computer_setup_text
		player_setup
	end

	def player_setup
		puts "The Cruiser is three units long and the Submarine is two units long."
		quick_pause; page_break
		print player_board.render
		puts "Enter the coordinates for the Cruiser (3 coordinates each separated by a space): "
		place_cruiser
		page_break
		print player_board.render(true)
		puts "Enter the coordinates for the Submarine (2 coordinates each separated by a space): "
		place_submarine
		render_boards
		computer_turn
	end

	def computer_turn
		computer_coordinate = @computer_coordinates.sample
		@computer_coordinates.delete(computer_coordinate)
		puts "The computer has taken a shot at coordinate: #{computer_coordinate}"
		quick_pause
		player_board.fire_upon(computer_coordinate)
		puts "The computer's shot was a miss!" if player_board.render_indiv(computer_coordinate) == "M"
		puts "The computer's shot was a hit!" if player_board.render_indiv(computer_coordinate) == "H"
		puts "The computer's shot was a hit and your vessel has sunk!" if player_board.render_indiv(computer_coordinate) == "X"
		render_boards
		computer_won if player_fleet_sunk?
		player_turn
	end

	def player_turn
		puts "It's your turn! Enter the coordinate for your shot:"
		coordinate = gets.chomp.upcase
		computer_board.fire_upon(coordinate)
		quick_pause
		puts "Your shot was a miss!" if computer_board.render_indiv(coordinate) == "M"
		puts "Your shot was a hit!" if computer_board.render_indiv(coordinate) == "H"
	  puts "Your shot was a hit and the computer's vessel has sunk!" if computer_board.render_indiv(coordinate) == "X"
		render_boards
		user_won if computer_fleet_sunk?
		computer_turn
	end

	def computer_fleet_sunk?
		computer_submarine.sunk? && computer_cruiser.sunk?
	end

	def player_fleet_sunk?
		player_submarine.sunk? && player_cruiser.sunk?
	end

	def quick_pause
		sleep(0.25)
		puts "***"
		sleep (0.25)
		puts "**"
		sleep(0.25)
		puts"*"
		sleep(0.25)
	end

	def page_break
		puts "*" * 100
	end

	def welcome_message
		puts page_break
		puts "Welcome to:"
		puts battleship_writing
		puts page_break
		puts "Enter <p> to play. Enter <q> to quit."
	end

	def main_menu_input(input)
		if input == "p"
			computer_setup
		elsif input == "q"
			puts "Later, loser ✌️"
			exit
		else
			puts "Wrong input. Try again."
			return main_menu
		end
	end

	def computer_place_cruiser
		while computer_board.valid_placement?(@computer_cruiser, @cruiser_computer) == false
			@cruiser_computer << @computer_coordinates.sample(3) #if we have time, make this more intentional
			@cruiser_computer.flatten!
			if computer_board.valid_placement?(@computer_cruiser, @cruiser_computer) == false
				@cruiser_computer.clear
			else
				break
			end
		end
	end

	def computer_place_submarine
		while computer_board.valid_placement?(@computer_submarine, @submarine_computer) == false
			@submarine_computer << @computer_coordinates.sample(2)
			@submarine_computer.flatten!
			if computer_board.valid_placement?(@computer_submarine, @submarine_computer) == false
				@submarine_computer.clear
			else
				break
			end
		end
	end

	def computer_setup_text
		quick_pause
		puts "I have laid out my ships on the grid."
		quick_pause
		puts "You now need to lay out your two ships."
		quick_pause
	end

	def render_boards
		quick_pause
		page_break
		puts "=============COMPUTER BOARD============="
		print computer_board.render
		puts "==============PLAYER BOARD=============="
		print player_board.render(true)
		quick_pause
	end

	def user_won
		puts "You have won this round thanks to your tactical superiority."
		page_break
		game_over
		quick_pause
		main_menu
	end

	def computer_won
		puts "You have lost this round due to your tactical inferiority."
		page_break
		game_over
		quick_pause
		main_menu
	end

	def place_cruiser
		while @cruiser_placed == false
			@cruiser_player << gets.upcase.split
			@cruiser_player.flatten!
			if @cruiser_player.all? {|coordinate| player_board.valid_coordinate?(coordinate)} #at some point we could add valid_coordinate into the valid_placement method
					if player_board.valid_placement?(@player_cruiser, @cruiser_player)
						player_board.place(@player_cruiser, @cruiser_player)
						@cruiser_placed = true
					else
						@cruiser_player.clear
						puts "Those are invalid coordinates. Please try again:"
					end
			else
					@cruiser_player.clear
					puts "Those are invalid coordinates. Please try again:"
			end
		end
	end

	def place_submarine
		while @submarine_placed == false
			@submarine_player << gets.upcase.split
			@submarine_player.flatten!
			if @submarine_player.all? {|coordinate| player_board.valid_coordinate?(coordinate)}
					if player_board.valid_placement?(@player_submarine, @submarine_player)
						player_board.place(@player_submarine, @submarine_player)
						@submarine_placed = true
					else
						@submarine_player.clear
						puts "Those are invalid coordinates. Please try again:"
					end
			else
					@submarine_player.clear
					puts "Those are invalid coordinates. Please try again:"
			end
		end
	end

	def battleship_writing
		puts "
		╭━━╮╭━━━┳━━━━┳━━━━┳╮╱╱╭━━━┳━━━┳╮╱╭┳━━┳━━━╮
		┃╭╮┃┃╭━╮┃╭╮╭╮┃╭╮╭╮┃┃╱╱┃╭━━┫╭━╮┃┃╱┃┣┫┣┫╭━╮┃
		┃╰╯╰┫┃╱┃┣╯┃┃╰┻╯┃┃╰┫┃╱╱┃╰━━┫╰━━┫╰━╯┃┃┃┃╰━╯┃
		┃╭━╮┃╰━╯┃╱┃┃╱╱╱┃┃╱┃┃╱╭┫╭━━┻━━╮┃╭━╮┃┃┃┃╭━━╯
		┃╰━╯┃╭━╮┃╱┃┃╱╱╱┃┃╱┃╰━╯┃╰━━┫╰━╯┃┃╱┃┣┫┣┫┃
		╰━━━┻╯╱╰╯╱╰╯╱╱╱╰╯╱╰━━━┻━━━┻━━━┻╯╱╰┻━━┻╯"
	end

	def game_over
		puts "
		░██████╗░░█████╗░███╗░░░███╗███████╗  ░█████╗░██╗░░░██╗███████╗██████╗░
		██╔════╝░██╔══██╗████╗░████║██╔════╝  ██╔══██╗██║░░░██║██╔════╝██╔══██╗
		██║░░██╗░███████║██╔████╔██║█████╗░░  ██║░░██║╚██╗░██╔╝█████╗░░██████╔╝
		██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░  ██║░░██║░╚████╔╝░██╔══╝░░██╔══██╗
		╚██████╔╝██║░░██║██║░╚═╝░██║███████╗  ╚█████╔╝░░╚██╔╝░░███████╗██║░░██║
		░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝  ░╚════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝"
	end
end
