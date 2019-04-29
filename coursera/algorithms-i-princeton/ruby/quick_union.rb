class QuickUnion
  def initialize(size)
    @unions = (0..size).to_a
    @groups_count = size
  end

  def union(p, q)
    @unions[p] = q
  end

  def connected?(p, q)
    true
  end

  def count
    @groups_count
  end

  attr_reader :size
end
