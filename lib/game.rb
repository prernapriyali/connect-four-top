# frozen-string-literal: true

require_relative './player.rb'
require_relative './rules.rb'
require_relative './display.rb'
require_relative './grid.rb'

# Plays the game
class Game
  attr_reader :players, :grid, :winner
  include Rules
  include Display
  include Grid
  def initialize
    @players = [name_players(1), name_players(2)]
    @grid = Array.new(6) { Array.new(7) { "\u25EF" } }
  end

  def name_players(player_number)
    player_number == 1 ? ask_for_player_one_name : ask_for_player_two_name
    name = gets.chomp
    Player.new(name)
  end

  def make_player_discs
    players.each do |player|
      ask_for_disk_colour(player)
      disc_code = gets.chomp.downcase
      player.create_disc(disc_code)
    end
  end

  def play_game
    display_grid(grid)
    @winner = make_move
    winner_announcement(winner)
  end

  def make_move
    @players.cycle do |player|
      column = request_column_input(player)
      add_disc(column, player.disc)
      display_grid(grid)
      return player if scan_grid(grid)
    end
  end

  def add_disc(column, disc)
    grid.each_with_index do |row, row_index|
      next unless row[column] == "\u25EF"

      @grid[row_index][column] = disc and break
    end
  end

  def request_column_input(player)
    loop do
      request_column_message(player)
      column = gets.chomp.to_i
      return (column - 1) if valid_column?(column)

      invalid_column_message
    end
  end

  def valid_column?(column)
    column.to_i.between?(1, 7) && !full_column?(grid, column)
  end
end
