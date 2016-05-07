require_relative "./states"
include States

# Mastermind - creates a secret code, checks guesses against this
# code
class CodeMaker
	def initialize(board)
		@secret_code = []
		@feedback = []
		@board = board
	end

    # create a new code - if codeval is not empty, use that
    # (convenience for testing)
	def create_code(codeval=[])
		if codeval.length > 0
			@secret_code = codeval
		else
			source_states = CODE_STATES.select {|s| s != :empty}
			4.times {@secret_code.push(source_states.sample)}
		end
	end

    # return the code - for test purposes
	def get_code # for testing only
		@secret_code
	end

    # compare the guess with the secret code, provide
    # feedback (Mastermind rules)
	def check_guess
	    guess = @board.get_guess
	    feedback = []
	    guess2 = Array.new(guess)
	    secret2 = Array.new(@secret_code)
	    # find exact matches
	    guess.each_index do |i|
	    	if guess[i] == @secret_code[i]
	    		feedback << :black
	    		guess2[i] = :matched
	    		secret2[i] = :matched
	    	end
	    end

	    # find other matches (right colour, wrong pos)
	    # matches must be distinct - i.e. a position
	    # in the secret code cannot be matched by more than
	    # one position in the guess
	    guess2.each_index do |i|
	    	if guess2[i] == :matched
	    		next
	    	else
	    		secret_pos = secret2.index(guess2[i])
	    		if secret_pos.nil?
	    			feedback << :empty
	    		else
	    			feedback << :white
	    			secret2[secret_pos] = :matched
	    		end
	    	end
	    end
	    if feedback.length < 4
	    	empty_arr = [:empty]*(4 - feedback.length)
	    	feedback += empty_arr
	    end
	    @board.set_feedback(feedback)
	end
end