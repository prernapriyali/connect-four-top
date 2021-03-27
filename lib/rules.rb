# frozen-string-literal: true

# Rules (including win condition rules)
module Rules
  def scan_grid(grid)
    discs = grid.flatten.uniq.reject { |disc| disc == "\u25EF" }
    return unless discs.length == 2

    column_winner(grid, discs) or row_winner(grid, discs) or either_diagonal(grid, discs)
  end

  def connect_four(altered_grid, disc)
    four_in_a_row = []
    altered_grid.each do |group|
      group.chunk { |disk_group| disk_group == disc }.each { |_, chunked_discs| four_in_a_row << chunked_discs }
    end
    # print "Four in a row for #{disc}\n\tCount: #{altered_grid.flatten.count(disc)}"
    # four_in_a_row.each { |g| print "#{g}\n" }
    four_in_a_row.any? { |group| group.count(disc) == 4 } ? disc : false
  end

  def column_winner(grid, discs)
    transformed_grid = []
    (0..6).each do |column_index|
      column = []
      grid.each do |row|
        column.push(row[column_index])
      end
      transformed_grid.push(column)
    end
    connect_four(transformed_grid, discs[0]) or connect_four(transformed_grid, discs[1])
  end

  def row_winner(grid, discs)
    connect_four(grid, discs[0]) or connect_four(grid, discs[1])
  end

  # Covers main and anti diagonal
  def either_diagonal(grid, discs)
    reverse_grid = grid.map(&:reverse)
    diagonal_winner(grid, discs) or diagonal_winner(reverse_grid, discs)
  end

  def diagonal_winner(grid, discs)
    diagonals = []
    loop_range = grid.size
    (-loop_range..loop_range).each { |last_row| diagonals << identify_diagonals(grid, last_row) }
    diagonals.compact!
    connect_four(diagonals, discs[0]) or connect_four(diagonals, discs[1])
  end

  def identify_diagonals(grid, last_row)
    return nil if last_row.zero?

    indices = diagonals_helper(last_row, grid.size, grid[0].size)
    diag_indices = (indices[0].zip indices[1])
    # print "\e[32mIndices: #{indices}\e[0m\n\e[33mDiag_indices: #{diag_indices}\e[0m\n"
    diag_indices.map { |row, col| diag_error(grid, row, col) }
  end

  def diag_error(grid, row, col)
    begin
      grid[row][col]
    rescue NoMethodError
      ''
    else
      grid[row][col]
    end
  end

  # Returns the right [row, col] indices much more clearly as its own method
  def diagonals_helper(last_row, row_size, col_size)
    limits = { positive: (last_row - col_size), negative: (last_row + row_size) }
    indices = { positive: [-1.downto(limits[:positive]), last_row.upto(col_size)].map(&:to_a),
                negative: [last_row.downto(-row_size), 0.upto(limits[:negative])].map(&:to_a) }
    return indices[:positive] if last_row.positive?

    indices[:negative]
  end

  def full_column?(grid, column)
    column_group = []
    grid.each { |row| column_group.push(row[column]) unless row[column] == '' }
    column_group.length == 7
  end
end
