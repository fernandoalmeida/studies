require 'minitest/autorun'
require_relative '../percolation'

class PercolationTest < Minitest::Test
  def test_a_porra_toda
    p = Percolation.new(3)

    # assert_equal(0, p.number_of_open_sites)
    assert_equal(false, p.percolates?)

    p.open(0, 0)
    # assert_equal(1, p.number_of_open_sites)
    assert_equal(false, p.percolates?)
    assert_equal(true, p.open?(0, 0))
    assert_equal(false, p.open?(0, 1))
    assert_equal(true, p.full?(0, 0))
    assert_equal(false, p.full?(0, 1))

    p.open(0, 1)
    # assert_equal(1, p.number_of_open_sites)
    assert_equal(false, p.percolates?)
    assert_equal(true, p.open?(0, 0))
    assert_equal(true, p.open?(0, 1))
    assert_equal(true, p.full?(0, 0))
    assert_equal(true, p.full?(0, 1))

    p.open(1, 1)
    p.open(1, 2)
    assert_equal(true, p.full?(1, 2))
    assert_equal(false, p.percolates?)

    p.open(2, 0)
    assert_equal(false, p.full?(2, 0))
    assert_equal(false, p.percolates?)

    p.open(2, 2)
    assert_equal(true, p.full?(2, 2))
    assert_equal(true, p.percolates?)
  end
end
