# frozen-string-literal: true

require_relative './../lib/game.rb'
require_relative './../lib/grid.rb'
require_relative './../lib/rules.rb'

describe Game do
  # included module: Grid
  # describe '#make_grid' do

  #   subject(:game_grid) { described_class.new }

  #   context 'when passed a grid with empty columns' do
  #     it 'prepends [xxxx] to represent column gaps' do
  #       grid = [%w[O O O], %w[O O], %w[O O O O]]
  #       grid_with_gaps = game_grid.make_grid(grid)
  #       expect(grid_with_gaps).to include('')
  #     end
  #   end
  # end

  describe '#display_grid' do
    let(:game_grid_display) { Class.new { extend Grid } }
    let(:grid_to_show) { [%w[O O O O], ['O', 'O', '', 'O'], ['', '', '', 'O']] }

    context 'when called' do
      before { allow(game_grid_display).to receive(:display_grid).with(grid_to_show) }
      it 'outputs a grid to the terminal' do
        game_grid_display.display_grid(grid_to_show)
        expect(game_grid_display).to have_received(:display_grid).with(grid_to_show)
      end
    end
  end

  # included module: Rules
    # No need to test:
      # scan_grid --> script method
      # diagonals_helper --> querying a hash
      # identify_diagonals --> (might change mind)

  describe '#row_winner' do
    subject(:game_row_winner) { described_class.new }

    context 'when a player\'s discs are in a sequence of four in a row' do
      it 'declares that player as the winner' do
        winning_row = [%w[O O O x O O O], %w[O x x O O O O]]
        discs = %w[O x]
        result = game_row_winner.row_winner(winning_row, discs)
        expect(result).to eq 'O'

        another_winning_row = [%w[O O x x x x O], %w[x x x O O O x]]
        another_result = game_row_winner.row_winner(another_winning_row, discs)
        expect(another_result).to eq 'x'
      end
    end
  end

  describe '#column_winner' do
    subject(:game_column_winner) { described_class.new }

    context 'when a player\'s discs are in a sequence of four in a column' do
      it 'delcares that player as the winner' do
        winning_column = [%w[O x x O x O x], %w[O O O x O x O], %w[O x x O x O x], %w[O O O x O x O]]
        discs = %w[O x]
        result = game_column_winner.column_winner(winning_column, discs)
        expect(result).to eq 'O'

        another_winning_column = [%w[O O x x x O O], %w[x x x O O x x], %w[O O x x x O O], %w[x x x O O x x]]
        another_result = game_column_winner.column_winner(another_winning_column, discs)
        expect(another_result).to eq 'x'
      end
    end
  end

  describe '#either_diagonal' do
    subject(:game_diagonal_winner) { described_class.new }

    context 'when a player\'s discs are in a sequence of four diagonally' do
      it 'declares them as the winner' do
        winning_main_diagonal = [%w[O x O x x O], %w[x O x x O x], %w[x O x O x x], %w[O x O x x x]]
        discs = %w[O x]
        result = game_diagonal_winner.either_diagonal(winning_main_diagonal, discs)
        expect(result).to eq 'O'

        winning_anti_diagonal = [%w[O O x O x x], %w[O O O x x O], %w[O x O x O O], %w[x x x O O O]]
        another_result = game_diagonal_winner.either_diagonal(winning_anti_diagonal, discs)
        expect(another_result).to eq 'x'
      end
    end
  end

  describe '#full_column?' do
    subject(:game_full_column) { described_class.new }
    context 'when a grid has a full column' do
      it 'returns true' do
        full_column = [%w[O x], %w[x O], %w[O x], %w[x O], %w[O x], %w[x O], %w[O x]]
        column = 0
        result = game_full_column.full_column?(full_column, column)
        expect(result).to be true
      end
    end

    context 'when a grid does not have a full column' do
      it 'returns false' do
        column_with_gaps = [%w[O x], %w[x O], %w[O x], %w[x O]]
        column = 0
        result = game_full_column.full_column?(column_with_gaps, column)
        expect(result).to be false
      end
    end
  end

  describe '#add_disc' do
    subject(:game_shift) { described_class.new }
    it 'adds a disc in a specified column' do
      column = 0
      disc = 'O'
      game_shift.add_disc(column, disc)
      flattened_grid_instance = game_shift.instance_variable_get(:@grid).flatten
      expect(flattened_grid_instance).to include 'O'
    end
  end

  describe '#valid_column?' do
    subject(:game_valid) { described_class.new }
    it 'returns true for values between 0 and 6 inclusive' do
      column = 3
      result = game_valid.valid_column?(column)
      expect(result).to be true
    end

    it 'returns false for any other values' do
      column = 'this feels kinda invalid...'
      result = game_valid.valid_column?(column)
      expect(result).to be false
    end
  end
end
