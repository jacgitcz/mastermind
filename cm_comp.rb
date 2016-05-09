require_relative "./states"
require_relative "./code_maker"
include States

# Mastermind - creates a secret code, checks guesses against this
# code - compute code setter
class ComputerCodeMaker < CodeMaker
	def initialize(board)
		super
	end

	def check_guess
	    guess = @board.get_guess
	    feedback = analyse_guess(guess)
	    @board.set_feedback(feedback)
	end
end