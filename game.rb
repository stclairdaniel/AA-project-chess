require './board'
require './player'
require './bishop'
require './king'

class Game

  attr_reader :player

  def initialize(player)
    @player = player
  end

end

board = Board.new
player = Player.new(board)
game = Game.new(player)
white_bishop = Bishop.new(:white, board, [2,2])
board[[2,2]] = white_bishop

black_bishop = Bishop.new(:black, board, [4,4])
board[[4,4]] = black_bishop

white_king = King.new(:white, board, [3,3])
board[[3,3]] = white_king

black_king = King.new(:black, board, [6,6])
board[[6,6]] = black_king

board.white_pieces = [white_bishop, white_king]
board.black_pieces = [black_bishop, black_king]

#
# p board.in_check?(:white)
# p board.in_check?(:black)

n = board.dup
p n
#game.player.move
