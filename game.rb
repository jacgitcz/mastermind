require_relative "./board"
require_relative "./code_maker"
require_relative "./code_breaker"
require_relative "./states"
include States

class Game
	def initialize
		@board = Board.new
		@cmaker = CodeMaker.new(@board)
		@cbreaker = CodeBreaker.new(@board)
	end

	def new_game
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
			puts "The code maker won!"
		end
	end
end