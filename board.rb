require_relative "./states"
include States

# Mastermind game board
class Board
	def initialize
		@guess_stack = []
		@feedback_stack = []
		@current_row = -1 # empty stack
	end

	def clear_board
		@guess_stack = []
		@feedback_stack = []
		@current_row = -1 # empty stack
	end

    # remaining turns
	def moves_left
		MAX_MOVES - 1 - @current_row
	end

    # check if correct code has been guessed
	def win?
		if @feedback_stack.length == 0
			result = false
		else
			result = @feedback_stack[@current_row].all? {|x| x == :black}
		end
		result
	end

    # accept a guess
	def set_guess(guess)
		if @current_row < MAX_MOVES
			@guess_stack.push(guess)
			@current_row += 1
		end
	end

    # return the current guess
	def get_guess
		@guess_stack[@current_row]
	end

    # accept feedback
	def set_feedback(feedback)
		if @current_row >= 0  # no guess, no feedback
			@feedback_stack[@current_row] = feedback
		end
	end

    # return the current feedback
	def get_feedback
		@feedback_stack[@current_row]
	end
    
    # displays a string rep of the board state
	def show_board
		outstr = ""
		@guess_stack.each_index do |i|
			guess = @guess_stack[i]
			guess.each do |s|
				outstr += DISPLAY_CODES[s] + " "
			end
			feedback = @feedback_stack[i]
			if !feedback.nil?
				outstr += " "
				feedback.each do |s|
					outstr += DISPLAY_FEEDBACK[s] + " "
				end
			end
			outstr += "\n"
		end
		outstr
	end
end