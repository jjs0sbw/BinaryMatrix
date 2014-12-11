# encoding : utf-8
#
# binary_matrix_utilities.rb
# Utilities that support different output forms for a BinaryMatrix instance
#
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-23-2014
# binary_matrix implements a binary matrix that supports Warfields Augumented Boolean Logic.  
# See http://systemsconcept.org for details.
#     Copyright (C) 2014  Joseph James Simpson

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.
# =Utility methods and functions for the BinaryMatrix class.
module Utilities
  # Makes all entries in the matrix that are greater than 1 equal to 1
  # * +matrix+ The target matrix
  def boolean_map(matrix)
    m_size = (matrix[0].length - 1)
    (0..m_size).map do
      |x| (0..m_size).map do
        |y| matrix[x][y] > 1 ? matrix[x][y] = 1 : matrix[x][y]
      end
    end
  end

  # Creates a standard id matrix
  # * +size+ The size of the square id matrix
  def id_matrix(size)
    id = Array.new(size) { Array.new(size, 0) }
    id[0][0] = 1
    (0..size - 1).map { |x| id[x][x] = 1 }
    id
  end
  
  # Compress two Boolean arrays into one
  # * +array_1+ The first Boolean array
  # * +array_2+ The second Boolean array
  # * +index_1+ The index of the first array
  def compress_array(array_1, array_2, index_1)
    sz = array_1.length - 1
    a_1 = array_1.dup
    a_2 = array_2.dup
    a_out = []
    (0..sz).each { |x| a_out[x] = a_1[x] + a_2[x] }
    (0..sz).each { |x| a_out[x] > 1 ? a_out[x] = 1 : a_out[x] }
    a_out[index_1] = 0 # change to index_1 may need to add index_2
    a_out
  end
 
  # Expand the matrix by one row and column at the end of the matrix
  # * +matrix+ The target matrix
  def expand_end(matrix)
    new_size = matrix[0].length
    new_row = Array.new(new_size, 0)
    new_matrix = matrix.dup
    new_matrix << new_row
    new_column = Array.new(new_size + 1, 0)
    new_matrix_t = new_matrix.transpose.dup
    new_matrix_t << new_column
    matrix_out = new_matrix_t.transpose.dup
    matrix_out
  end

  # Swap teh selected rows and olumns
  # * +index_1+ The first row and column
  # * +index_2+ The second row and column
  # * +matrix+ The target matrix
  # * +matrix_index The index of the target matrix
  def swap_row_column(index_1, index_2, matrix = bm,  matrix_index = bmi.mi)
    tm = matrix.dup
    i1 = matrix_index.index(index_1)
    i2 = matrix_index.index(index_2)
    ta1 = tm[i1]
    ta2 = tm[i2]
    tm[i1] = ta2
    tm[i2] = ta1
    tmt = tm.transpose
    tat1 = tmt[i1]
    tat2 = tmt[i2]
    tmt[i1] = tat2
    tmt[i2] = tat1
    tout = tmt.transpose.dup
    tout
  end

  # Swap the selected cells in the matrix index
  # * +index_1+  The index of the first cell
  # * +index_2+  The index of the second cell
  # * +matrix_intex+  The target matrix index
  def swap_index(index_1, index_2, matrix_index)
    tm = matrix_index.dup
    i1 = bmi.mi.index(index_1)
    i2 = bmi.mi.index(index_2)
    ta1 = tm[i1]
    ta2 = tm[i2]
    tm[i1] = ta2
    tm[i2] = ta1
    tm.dup
  end

  # Calculate the reachability matrix from the target matrix
  # * +matrix+ The target matrix
  def reachability_matrix(matrix)
    tmp_matrix = matrix.dup
    guard_num = 0
    check_matrix_1 = boolean_multiply(tmp_matrix, tmp_matrix)
    check_matrix_2 = boolean_multiply(check_matrix_1, check_matrix_1)
    until boolean_subtract(check_matrix_1, check_matrix_2) == 0 || guard_num > 10
      guard_num += 1
      check_matrix_1 = boolean_multiply(check_matrix_2, check_matrix_2)
      check_matrix_2 = boolean_multiply(check_matrix_1, check_matrix_1)
    end
    check_matrix_2
  end

  # Subtract an id matrix from the target matrix
  # * +matrix+  The target matrix
  def subtract_id_matrix(matrix)
    sz = (matrix[0].length - 1)
    (0..sz).map { |x| matrix[x][x] = 0 }
    matrix
  end
end
