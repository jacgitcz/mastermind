require_relative "./board"
require_relative "./cm_comp"
require_relative "./cm_human"
require_relative "./cb_comp"
require_relative "./cb_human"
require_relative "./states"
include States

class Game
	def initialize
		@board = Board.new
	end

	def new_game
		@board.clear_board # for case where we call new game repeatedly
		valid_choice = false
		while !valid_choice do
			puts "Do you want to play as code breaker (b) or setter (s)?"
			choice = gets.chomp.downcase
			case choice
			when "b"
				@cbreaker = HumanCodeBreaker.new(@board)
				@cmaker = ComputerCodeMaker.new(@board)
				valid_choice = true
			when "s"
				@cmaker = HumanCodeMaker.new(@board)
				@cbreaker = ComputerCodeBreaker.new(@board)
				valid_choice = true
			else
				puts "I'm sorry, I don't understand - please try again"
				valid_choice = false
			end
		end
		@cmaker.create_code
		win = false

		until win or @board.moves_left <= 0 do
		    @cbreaker.guess_code
		    @cmaker.check_guess
		    win = @board.win?
		    if @board.moves_left > 0
		    	@cbreaker.check_feedback
		    end 
		end
		if win
			puts "The code breaker won in #{MAX_MOVES - @board.moves_left}!"
		else
			puts "The code maker won! The code was #{@cmaker.get_code}."
		end
	end
end