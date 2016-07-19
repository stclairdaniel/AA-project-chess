require 'singleton'

class NullPiece

  include Singleton

  def initialize

  end

  def to_s
    "   "
  end

  def color
    nil
  end

  def dup
    NullPiece.instance
  end

end
