require './nullpiece'

class Board

  attr_reader :rows
  attr_accessor :white_pieces, :black_pieces

  def initialize
    @rows = Array.new(8) { Array.new(8) { NullPiece.instance} }
    @white_pieces = []
    @black_pieces = []
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @rows[row][col] = value
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    raise "No piece at start position" if piece == NullPiece.instance
    raise "Not a valid move" unless piece.valid_move?(end_pos)
    #update piece's position
    piece.pos = end_pos
    #update board
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def find_king(color)
    king = @rows.flatten.select { |piece| piece.color == color && piece.symbol == :K }[0]
    king_idx = @rows.flatten.index(king)
    king_row = king_idx / @rows.size
    king_col = king_idx % @rows.size
    [king_row, king_col]
  end

  def in_check?(color)
    king_pos = find_king(color)
    opponent_piece_array = color == :white ? @black_pieces : @white_pieces
    opponent_piece_array.any? { |piece| piece.moves.include?(king_pos) }
  end

  def dup
    new_board = Board.new
    @black_pieces.each { |piece| piece.class.new(piece.color, new_board, piece.pos)}
    @white_pieces.each { |piece| piece.class.new(piece.color, new_board, piece.pos)}
  end

  # def checkmate?(color)
  #   player_piece_array = color == :white ? @white_pieces : @black_pieces
  #   player_piece_array.each do |piece|
  #     piece.moves.each do |move|
  #     #need to implement dup
  #       board = self.dup
  #
  # end


end
