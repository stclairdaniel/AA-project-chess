require_relative "display"

class Player

  attr_reader :display, :color

  def initialize(board, color)
    @display = Display.new(board)
    @color = color
  end

  def command
    result = nil
    until result
      @display.render
      puts "It is #{@color}'s turn."
      result = @display.get_input
    end
    result
  end
end
