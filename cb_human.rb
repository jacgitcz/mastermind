require_relative "./code_breaker"
require_relative "./states"
include States

class HumanCodeBreaker < CodeBreaker
	def initialize(board)
		super
	end

    # Overrides guess_code in CodeBreaker
	def guess_code
		cmd = ""
		valid_guess = false
		until cmd == "e" && valid_guess do 
			puts "Enter ? for help, s to show the board or e to enter a guess: "
			cmd = gets.chomp.downcase
			case cmd
			when "?"
				puts "Colours are indicated by the first letter of the colour name."
				puts "That is, 'ROYG' indicates the sequence red, orange, yellow and green."
				puts "In the board display the feedback is shown to the right of the guess."
				puts "B in the guess display stands for blue, but in the feedback display it"
				puts "means black.  Guesses should contain 4 colours; they may include"
				puts "repeated colours e.g. 'RRGG' would be acceptable."
			when "s"
				puts @board.show_board
			when "e"
				puts "Enter guess with 4 colours (see help for letter codes):"
				guess_str = gets.chomp.upcase
				guess = []
				valid_guess = true
				guess_str.each_char do |c|
					colour = DISPLAY_CODES.key(c)
					if colour.nil?
						valid_guess = false
					else
						guess << colour
					end
				end
				if !valid_guess
					puts "You entered something I didn't recognize, please try again."
				elsif guess.length != 4
					puts "You didn't enter exactly 4 colours, please try again."
					valid_guess = false
				end
			end		
	    end
	    @board.set_guess(guess)	
	end

	def check_feedback
		puts "Here is your feedback:"
		puts @board.show_board
	end
end