class Piece

  attr_reader :pos, :symbol

  def initialize(color, board, pos)
    @color = color
    @opponent_color = @color == :white ? :black : :white
    @board = board
    @pos = pos
  end

  def move_into_check?(end_pos)
    temp_board = @board.dup
    temp_board.in_check?(@color)
  end

  def valid_moves
    moves.select do |row, col|
      # not moving ontop of same color
      @board[[row,col]].color != @color
    end
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end

  def to_s
    " #{@symbol.to_s} "
  end

end
