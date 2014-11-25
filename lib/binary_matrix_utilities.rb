# encoding : utf-8
#
# binary_matrix_utilities.rb
# Utilities that support different output forms for a BinaryMatrix instance
#
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-23-2014
module Utilities

  def boolean_map(matrix)
    m_size = matrix[0].length
    (0..m_size - 1).map do
      |x| (0..m_size - 1).map do
        |y| if matrix[x][y] > 1
              matrix[x][y] = 1
            end
        end 
    end 
  end

  def id_matrix(size)
    id = Array.new(size) { Array.new(size, 0) }
    id[0][0] = 1
    (0..size-1).map { |x| id[x][x] = 1 }
    id
  end  

  def compress_array(array_1, array_2, index_2)
    sz = array_1.length - 1
    a_1 = array_1.dup
    a_2 = array_2.dup
    a_out = []
    (0..sz).each { |x| a_out[x] = a_1[x] + a_2[x] }
    (0..sz).each { |x| a_out[x] > 1 ? a_out[x] = 1 : a_out[x] }
    a_out[index_2] = 0
    a_out
  end


end

