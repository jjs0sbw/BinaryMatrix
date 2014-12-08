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
    #i1 = temp_mi[index_1 - 1]
    #i2 = temp_mi[index_2 - 1]
    i1 = temp_mi.index([index_1])
    i2 = temp_mi.index([index_2])
    #puts " The indexes -mi 1- are #{i1 } and #{i2}"
    #temp_mi[i1[0]-1].push(i2[0])
    #temp_mi.delete_at(i2[0] - 1)
    temp_mi[i1].push(temp_mi[i2])
    temp_mi.delete_at(i2)
    #puts "22 length is #{mi.length }\n" 
    mi = temp_mi # added mi =
    #puts "33 length is #{mi.length }\n" 
    mi
  end  
end
