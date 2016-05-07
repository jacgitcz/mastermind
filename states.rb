module States
	MAX_MOVES = 12
	CODE_STATES = [:empty,:red,:orange,:yellow,:green,:blue,:purple]
	FEEDBACK_STATES = [:empty,:black,:white]
	DISPLAY_CODES = {:empty => "-", :red => "R", :orange => "O", :yellow => "Y",
	               :green => "G", :blue => "B", :purple => "P"}
	DISPLAY_FEEDBACK = {:empty => "-", :black => "B", :white => "W"}
end