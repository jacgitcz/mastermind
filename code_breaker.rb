require_relative "./states"
include States

class CodeBreaker
	def initialize(board)
		source_arr = CODE_STATES.select {|x| x != :empty}
		@next_guess = source_arr.sample(4)
		@board = board
	end

    # guess the next code
    # V1 just gets code from human player
	def guess_code
				
	end

	def check_feedback
		
	end
end