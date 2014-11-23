# encoding : utf-8
#
# An index of a binary matrix
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-22-2014
class MatrixIndex
  attr_accessor :mi
  def initialize(size)
    @mi = Array.new(size) { |i| Array.new(1, i + 1 ) }
  end
end