require './steppable'
require './piece'

class Knight < Piece
  include Steppable

  attr_reader :symbol, :move_dirs, :color

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :k
    #placeholder for now - need to add attacking logic
    @move_dirs = [[-1,0]]
    @initial_pos = pos
  end

  def at_start_row?
    @pos == @initial_pos
  end

end
