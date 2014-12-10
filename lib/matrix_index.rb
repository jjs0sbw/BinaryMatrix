# encoding : utf-8
#
# An index of a binary matrix
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-22-2014
class MatrixIndex
  attr_accessor :mi
  def initialize(size)
    @mi = Array.new(size) { |i| Array.new(1, i + 1) }
  end

  def compress_index(index_1, index_2)
    temp_mi = mi.dup
    i1 = temp_mi.index([index_1])
    i2 = temp_mi.index([index_2])
    temp_mi[i1].push(temp_mi[i2])
    temp_mi.delete_at(i2)
    mi = temp_mi
    mi
  end
end
