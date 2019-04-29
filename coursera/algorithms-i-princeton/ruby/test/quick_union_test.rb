require 'minitest/autorun'
require_relative '../quick_union'

class QuickUnionTest < Minitest::Test
  def test_initialization
    qf = QuickUnion.new(5)

    assert_equal(qf.unions, [0, 1, 2, 3, 4])
    assert_equal(qf.count, 5)
  end

  def test_union
    qf = QuickUnion.new(5)

    qf.union(2, 3)

    assert_equal(qf.unions, [0, 1, 3, 3, 4])
    assert_equal(qf.count, 4)
  end

  def test_duplicated_union
    qf = QuickUnion.new(5)

    qf.union(2, 3)
    qf.union(3, 2)

    assert_equal(qf.unions, [0, 1, 3, 3, 4])
    assert_equal(qf.count, 4)
  end

  def test_connected
    qf = QuickUnion.new(5)

    qf.union(2, 3)

    assert_equal(qf.connected?(2, 3), true)
    assert_equal(qf.connected?(3, 2), true)
    assert_equal(qf.connected?(2, 4), false)
  end

  def test_count
    qf = QuickUnion.new(5)

    qf.union(2, 3)
    qf.union(1, 4)
    qf.union(0, 2)

    assert_equal(qf.count, 2) # [3, 4, 3, 3, 4]
  end
end
