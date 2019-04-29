require_relative './quick_find.rb';

class Percolation
  def initialize(grid_columns)
    @grid_columns = grid_columns
    @total_cells = grid_columns * grid_columns
    @virtual_top = @total_cells
    @virtual_bottom = @total_cells + 1
    @opened_cells = Array.new(@total_cells+1, false)
    @opened_cells[@virtual_top] = true
    @opened_cells[@virtual_bottom] = true
    @union_find = QuickFind.new(@total_cells + 2)
  end

  def number_of_open_sites
    @total_cells - @union_find.count + 1
  end

  def open(row, col)
    i = index(row, col)
    @opened_cells[i] = true
    neighbors(i).each do |a|
      @union_find.union(i, a) if @opened_cells[a]
    end
  end

  def neighbors(i)
    result = []

    up = i - @grid_columns
    result << up if up >= 0

    down = i + @grid_columns
    result << down if down <= @total_cells - 1

    left = i - 1
    result << left if line(left) == line(i)

    right = i + 1
    result << right if line(right) == line(i)

    result << @virtual_top if line(i) == 0

    result << @virtual_bottom if line(i) == line(@total_cells - 1)

    result
  end

  def line(i)
    i / @grid_columns
  end

  def index(row, col)
    (@grid_columns * row) + col
  end

  def open?(row, col)
    @opened_cells[index(row, col)]
  end

  def full?(row, col)
    @union_find.connected?(index(row, col), @virtual_top)
  end

  def percolates?
    @union_find.connected?(@virtual_top, @virtual_bottom)
  end
end
