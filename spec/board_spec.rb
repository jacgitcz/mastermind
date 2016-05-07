require_relative "../board"
require_relative "../states"
include States

describe Board do
	before(:each) do
		@b = Board.new
	end

	it "starts with the right values" do
		expect(@b.moves_left).to eq(States::MAX_MOVES)
		expect(@b.win?).to eq false
	end

	it "accepts a guess" do
		@b.set_guess([:red,:green,:blue,:yellow])
		expect(@b.moves_left).to eq(States::MAX_MOVES - 1)
		expect(@b.get_guess).to eq [:red,:green,:blue,:yellow]
	end

	it "accepts feedback" do
		@b.set_guess([:red,:green,:blue,:yellow])
		@b.set_feedback([:white,:black,:empty,:empty])
		expect(@b.get_feedback.sort).to eq [:black,:empty,:empty,:white]
		expect(@b.moves_left).to eq(States::MAX_MOVES - 1)
	end

	it "detects a win" do
		@b.set_guess([:red,:green,:orange,:purple])
		@b.set_feedback([:black,:black,:black,:black])
		expect(@b.win?).to eq true
		@b.set_feedback([:black,:black,:white,:empty])
		expect(@b.win?).to eq false
	end

	it "can display the board state" do
		@b.set_guess([:red,:green,:orange,:purple])
		@b.set_feedback([:black,:black,:black,:black])
		@b.set_guess([:yellow,:blue,:red,:green])
		@b.set_feedback([:black,:black,:empty,:white])
		@b.set_guess([:purple,:blue,:red,:yellow])
		expect(@b.show_board).to eq("R G O P  B B B B \nY B R G  B B - W \nP B R Y \n")
	end
end