require_relative "./code_breaker"
require_relative "./states"
include States

class ComputerCodeBreaker < CodeBreaker
	def initialize(board)
		super
		@right_colours = []
		@wrong_colours = []
		@source_colours = CODE_STATES.select {|x| x != :empty}
		@perm_done = false
		@perm_index = 0
	end

	def guess_code
		if @right_colours.length < 4
			@last_colour = @source_colours.sample
			@next_guess = [@last_colour]*4
		else
			@next_guess = @combos[@perm_index]
		end
		@board.set_guess(@next_guess)
	end

	def check_feedback
		feedback = @board.get_feedback
		if @right_colours.length < 4
			empty_slots = feedback.count(:empty)
			@source_colours.delete(@last_colour)
			case empty_slots
			when 4 # no matches
			when 0..3
			   colours = [@last_colour]*(4 - empty_slots)
			   @right_colours += colours
			end
			if @right_colours.length == 4 && !@perm_done
				@combos = @right_colours.permutation.to_a
				@perm_done = true
			end
		else
			if feedback.all? {|s| s == :black} # win, do nothing
			else
				@combos.select! {|c| feedback == analyse_poss(c)} 
				@perm_index = (@perm_index + 1) % @combos.length		
			end
		end
	end

    # tries various possible codes to determine what feedback would
    # be produced for the current code
	def analyse_poss(poss_code)
		feedback = []
	    guess2 = Array.new(@next_guess)
	    secret2 = Array.new(poss_code)
	    # find exact matches
	    @next_guess.each_index do |i|
	    	if @next_guess[i] == poss_code[i]
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
	    feedback
	end
end