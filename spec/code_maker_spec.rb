require_relative "../cm_comp"
require_relative "../board"
require_relative "../states"
include States

describe ComputerCodeMaker do
	before(:each) do
		@b = Board.new
		@cm = ComputerCodeMaker.new(@b)
	end

	it "sets up a supplied code" do
		@cm.create_code([:red,:orange,:yellow,:blue])
		expect(@cm.get_code).to eq [:red,:orange,:yellow,:blue]
	end

	it "generates a valid random code" do
		@cm.create_code
		expect(@cm.get_code).not_to include(:empty)
		expect(@cm.get_code.length).to eq 4
		expect(@cm.get_code).to satisfy("codes are all valid") do |statevals|
			statevals.all? {|v| CODE_STATES.include?(v)}
		end
	end

	it "generates correct feedback for a win" do
		@cm.create_code([:red,:orange,:yellow,:blue])
		@b.set_guess([:red,:orange,:yellow,:blue])
		@cm.check_guess
		expect(@b.get_feedback).to eq [:black,:black,:black,:black]
	end

	it "generates all three types of feedback" do
		@cm.create_code([:red,:orange,:yellow,:blue])
		@b.set_guess([:orange,:red,:purple,:blue])
		@cm.check_guess
		expect(@b.get_feedback.count(:white)).to eq 2
		expect(@b.get_feedback.count(:black)).to eq 1
		expect(@b.get_feedback.count(:empty)).to eq 1
	end

	it "generates correct feedback for unusual guesses" do
		@cm.create_code([:red,:orange,:yellow,:blue])
		@b.set_guess([:orange,:orange,:orange,:orange])
		@cm.check_guess
		expect(@b.get_feedback.count(:black)).to eq 1
		expect(@b.get_feedback.count(:empty)).to eq 3
		@b.set_guess([:green,:green,:purple,:purple])
		@cm.check_guess
		expect(@b.get_feedback.count(:empty)).to eq 4
		@b.set_guess([:orange,:red,:blue,:yellow])
		@cm.check_guess
		expect(@b.get_feedback.count(:white)).to eq 4
	end
end