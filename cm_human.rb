require_relative "./states"
require_relative "./code_maker"
include States

# Mastermind - creates a secret code, checks guesses against this
# code - human code setter
class HumanCodeMaker < CodeMaker
	def initialize(board)
		super
	end

	def create_code
		valid_code = false
		while !valid_code do
			puts "Enter ? for help, 'c' for random code creation, 'm' for manual code creation, 'e' to exit:"
			cmd = gets.chomp.downcase
			case cmd
			when "?"
				puts "If you enter 'c', the computer will create a random code for you."
				puts "If you enter 'm' you can create your own code.  To enter your own"
				puts "code, use a string of 4 letters, where each letter is the 1st letter of"
				puts "the colour you want in that position.  For example, 'ROYB' would be a code with"
				puts "red in position 1, orange in position 2 and so on"
			when "c"
				super
				puts "The secret code is : #{codes_to_s(@secret_code,DISPLAY_CODES)}."
			when "m"
				puts "Please enter a 4 character string to set the code (see help):"
				codestr = gets.chomp.upcase
				if codestr.length != 4
					puts "Please enter exactly 4 characters!"
					valid_code = false
				end
			when "e"
				if @secret_code.length == 4
					valid_code = true
				end
			end
		end
	end

	def check_guess
		guess = @board.get_guess
		puts "The other player guessed #{codes_to_s(guess,DISPLAY_CODES)}."
		feedback = analyse_guess(guess)
		puts "The feedback for this guess is #{codes_to_s(feedback,DISPLAY_FEEDBACK)}"
		puts "Press ENTER to continue"
		cont = gets.chomp
		@board.set_feedback(feedback)
		@board.show_board
	end

	private

	def codes_to_s(code,lookup)
		codestr = ""
		code.each do |s|
			codestr += lookup[s] + " "
		end
		codestr
	end

	
end