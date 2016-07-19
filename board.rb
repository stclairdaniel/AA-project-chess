require './nullpiece'
require 'byebug'

class Board

  attr_reader :rows
  attr_accessor :white_pieces, :black_pieces

  def initialize
    @rows = Array.new(8) { Array.new(8) { NullPiece.instance} }
  end

  def make_starting_grid
    self[[7,0]] = Rook.new(:white, self, [7,0])
    self[[7,1]] = Knight.new(:white, self, [7,1])
    self[[7,2]] = Bishop.new(:white, self, [7,2])
    self[[7,3]] = Queen.new(:white, self, [7,3])
    self[[7,4]] = King.new(:white, self, [7,4])
    self[[7,5]] = Bishop.new(:white, self, [7,5])
    self[[7,6]] = Knight.new(:white, self, [7,6])
    self[[7,7]] = Rook.new(:white, self, [7,7])

    (0..7).each { |pawn_col| self[[6,pawn_col]] = Pawn.new(:white, self, [6, pawn_col])}
    (0..7).each { |pawn_col| self[[1,pawn_col]] = Pawn.new(:black, self, [1, pawn_col])}

    (0..7).each { |black_row| self[[0,black_row]] = self[[7,black_row]].class.new(:black, self, [0, black_row]) }


    make_piece_arrays
  end

  def make_piece_arrays
    @white_pieces = @rows.flatten.select{ |piece| piece.color == :white }
    @black_pieces = @rows.flatten.select{ |piece| piece.color == :black }
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

    make_piece_arrays
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
    opponent_piece_array.any { |piece| piece.moves.include?(king_pos) }
  end

  def dup
    new_board = Board.new

    @black_pieces.each { |piece| new_board[piece.pos] = piece.class.new(piece.color, new_board, piece.pos) }
    @white_pieces.each { |piece| new_board[piece.pos] = piece.class.new(piece.color, new_board, piece.pos) }

    new_board.make_piece_arrays
    new_board
  end

  def checkmate?(color)
    player_piece_array = color == :white ? @white_pieces : @black_pieces

    player_piece_array.all? { |piece| piece.valid_moves.empty? }
  end

  def render
    @rows.each { |row| p row.map(&:to_s).join("|") }
  end

end
