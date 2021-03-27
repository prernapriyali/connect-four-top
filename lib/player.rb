# frozen-string-literal: true

# Represent a player and their disc
class Player
  attr_reader :name, :disc
  def initialize(name)
    @name = name
    @disc = ''
  end

  def create_disc(colour_code)
    colour = select_colour(colour_code)
    @disc = "\e[#{colour}m\u25CF\e[0m"
  end

  def select_colour(colour_code)
    colours = {
      'y' => '33',
      'b' => '34',
      'g' => '32',
      'r' => '31',
      'm' => '35',
      'c' => '36'
    }
    return "38;5;#{Random.rand(50..230)}" unless colours.keys.include? colour_code

    colours[colour_code]
  end
end
