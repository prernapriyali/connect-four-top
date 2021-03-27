# frozen-string-literal: true

require_relative './../lib/player.rb'

describe Player do
  describe '#create_disc' do
    subject(:player_disc) { described_class.new '' }
    context 'when called with a valid colour code' do
      it 'creates a disc of that colour' do
        colour_code = 'r'
        bash_colour_code = '31m'
        player_disc.create_disc(colour_code)
        disc = player_disc.instance_variable_get(:@disc)
        expect(disc).to include(bash_colour_code)
      end
    end

    context 'when called with an invalid colour code' do
      it 'creates a disc with a random colour' do
        colour_code = 'j'
        expect(Random).to receive(:rand).with(100..200)
        player_disc.create_disc(colour_code)
      end
    end
  end
end
