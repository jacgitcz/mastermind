# mastermind

Plays the game of Mastermind.  Version 1 has a computer code setter and human code breaker.

Structure: 4 classes - Board, CodeMaker, CodeBreaker, Game, plus a module States

CodeMaker - generates a secret code, compares it with code guesses that CodeBreaker puts on the Board, and puts feedback onto the Board.  A new code is generated on demand from Game

CodeBreaker - puts guesses onto the Board, gets feedback from the Board (feedback which has been set by CodeMaker)

Board - stores guesses and feedback, and provides for adding guesses and feedback, and reading them back. It also indicates how many moves are left, and whether the current guess was a win.

CodeMaker and CodeBreaker do not communicate directly, only through the Board.

Game - runs the game: instantiates the other three objects, then ensures the following sequence of events

Generate code -> CodeMaker

loop
  generate guess -> CodeBreaker
  generate feedback -> CodeMaker
  check Board for win, get moves left
until win or no moves left

The States module is just to provide a common source for constants used by all the classes (possible states of a code guess position = empty + 6 colours, poss states of feedback= empty plus 2 other colours)