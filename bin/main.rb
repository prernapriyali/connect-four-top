# frozen-string-literal: true

require_relative './../lib/game.rb'
require_relative './../lib/display.rb'

# Interface for Connect Four
class Main
  attr_reader :connect_four
  include Display
  def initialize
    welcome
  end

  def start
    loop do
      @connect_four = Game.new
      connect_four.make_player_discs
      connect_four.play_game
      continue_program_message
      continue_program = gets.chomp.downcase
      break unless %w[c continue].include? continue_program
    end
    outro
  end
end

main = Main.new
main.start
