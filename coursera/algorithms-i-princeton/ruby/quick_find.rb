class QuickFind
  def initialize(size)
    @unions = (0..size-1).to_a
    @groups_count = size
  end

  def union(p, q)
    return if connected?(p, q)

    p_id = find(p)
    q_id = find(q)

    unions.each_with_index do |id, i|
      if id == p_id
        unions[i] = q_id
        @groups_count -= 1
      end
    end
  end

  def find(p)
    unions[p]
  end

  def connected?(p, q)
    find(p) == find(q)
  end

  def count
    @groups_count
  end

  attr_reader :unions
end
