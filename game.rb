require './board'
require './player'
require './bishop'
require './rook'
require './king'
require './knight'
require './queen'
require './pawn'
require 'time'

class Game

  attr_reader :white, :black

  def initialize(board = Board.new)
    @board = board
    @board.make_starting_grid

    @white = Player.new(board, :white)
    @black = Player.new(board, :black)

    @current_player = @white
  end

  def swap_player
    @current_player = @current_player == @white ? @black : @white
  end

  def loser
    [:white, :black].select { |color| @board.checkmate?(color) }[0]
  end

  def move
    start_pos = @current_player.command
    end_pos = @current_player.command

    @board.move(start_pos, end_pos) if @board[start_pos].color == @current_player.color
  end

  def run
    until loser
      move
      swap_player
    end

    puts "#{loser} loses."
  end

  def rand_move
    pieces = @current_player.color == :white ? @board.white_pieces : @board.black_pieces
    moves = pieces.each_with_object({}) do |piece, hash|
      piece_moves = piece.valid_moves
      hash[piece.pos] = piece_moves unless piece_moves.empty?
    end

    start_pos = moves.keys.sample
    end_pos = moves[start_pos].sample

    @board.move(start_pos, end_pos)
  end

  def rand_run
    # start = Time.now
    until loser # || Time.now - start > 10
      @current_player.display.render
      rand_move
      sleep(0.5)
      swap_player
    end
    @current_player.display.render
    puts "#{loser} loses."
    loser
  end
end

game = Game.new()
game.rand_run()


# results = []
# times = []
# 10.times do
#   start = Time.now
#   game = Game.new
#   results << game.rand_run
#   times << Time.now - start
# end
# p results
# p times

# game.player.move
