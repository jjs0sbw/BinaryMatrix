# binary_matrix implements a binary matrix that supports Warfields Augumented Boolean Logic.  See http://systemsconcept.org for details.
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


require "#{File.dirname(__FILE__)}/binary_matrix/version"
require "#{File.dirname(__FILE__)}/matrix_index"
require "#{File.dirname(__FILE__)}/binary_matrix_utilities"
require "#{File.dirname(__FILE__)}/log_and_print"

# =Binary matrix class for Warfield Augumented Boolean Logic
# This program creates an initial binary matrix populated with 
# all zeros in the matrix cells.
#
# The system structuring relation associated with this version of
# the binary matrix softare is a binary relation with the following properties:
#  * transitive
#  * irreflexive
#  * asymmetric
# See http://systemsconcept.org/

class BinaryMatrix
  include Utilities
  include LogAndPrint
  # Accessable attributes
  attr_accessor :size, :number_of_rows, :number_of_columns, :bm, :bmi

  # Create the initial binary matrix filled with zeros of size (size by size).
  # 
  # Create the initial binary matrix index of size (size).
  # * +size+ - Size of the square binary matrix. Length of the matrix index.
  def initialize(size)
    @size = size
    @number_of_rows = size
    @number_of_columns = size
    @bm = Array.new(size) { Array.new(size, 0) }
    @bmi = MatrixIndex.new(size)
  end

  # Adds together all the values in the binary matrix (sum all values)
  # * +matrix+ - The matrix containing the cells to be summed.
  def add(matrix = bm)
    sum = 0
    matrix.each { |x| x.each { |y| sum += y } }
    sum
  end
  
  # Enters a 1 into the selected matrix cell.
  # * +index_1+ The first cell index
  # * +index_2+ The second cell index
  # * +number+ The number to be entered into the selected cell
  # * +matrix+ The matrix that contains the cell
  # * +matrix_in+ The index of the matrix
  def enter_cell_content(index_1, index_2, number = 1, matrix = bm, matrix_in = bmi.mi)
    number = 0 if index_1 == index_2
    r_1 = matrix_in.index(index_1)
    r_2 = matrix_in.index(index_2)
    matrix[r_1][r_2] = number
    matrix
  end
  
  # Sums the contents from the same cell in each matrix.  Returning a matrix with the values.
  # * +matrix_one+ The first square matirx to be added. Must be same size as matrix_two.
  # * +matrix_two+ The second square matirx to be added. Must be same size as matrix_one.
  def boolean_add(matrix_one, matrix_two)
    temp_matrix_one = matrix_one.dup
    temp_matrix_two = matrix_two.dup
    sz = (temp_matrix_two[0].length - 1)
    temp_matrix_out = Array.new(sz + 1) { Array.new(sz + 1, 0) }
    (0..sz).map do | x|
      (0..sz).map do |y|
        temp_matrix_out[x][y] = (temp_matrix_one[x][y] + temp_matrix_two[x][y])
      end
    end
    boolean_map(temp_matrix_out)
    temp_matrix_out
  end

  # Subtracts matrix_two from matrix_one.  Must be careful to use this correctly.
  # * +matrix_one+ The first matrix to subtract from matrix_two.
  # * +matrix_two+ The second matrix.
  def boolean_subtract(matrix_one, matrix_two)
    temp_matrix_one = matrix_one.dup
    temp_matrix_two = matrix_two.dup
    sz = (temp_matrix_two[0].length - 1)
    temp_matrix_out = Array.new(size) { Array.new(size, 0) }
    (0..sz).map do | x|
      (0..sz).map do |y|
        temp_matrix_out[x][y] = (temp_matrix_one[x][y] - temp_matrix_two[x][y])
      end
    end
    boolean_map(temp_matrix_out)
    temp_matrix_out
  end

  # Multiplies matrix_one by matrix_two.  Provides a Boolean result
  # * +matrix_one+ The first matrix to be multiplied.
  # * +matrix_two+ The second matrix to be multiplied.
  def boolean_multiply(matrix_one, matrix_two)
    sz = (matrix_one[0].length - 1)
    id_1 = id_matrix(size).dup
    id_2 = id_matrix(size).dup
    m_1 = boolean_add(id_1, matrix_one.dup)
    m_2 = boolean_add(id_2, matrix_two.dup)
    m_2_t = m_2.transpose
    b_m_out = (0..sz).map do |j|
      (0..sz).map { |i| m_1[j].zip(m_2_t[i]).map { |x, y| x * y }.inject(:+) }
    end
    boolean_map(b_m_out)
    b_m_out
  end
  
  # Expands the selecred matrix by one row and colunm at selected index
  # * +matrix+ The matrix to be expanded
  # * +index_1+ The index where the matrix is expanded
  def expand(matrix, index_1)
    new_matrix = expand_end(matrix)
    last_index = new_matrix[0].length - 1
    matrix_out = swap_row_column([index_1], [last_index], new_matrix)
    matrix_out
  end
  
  # Compress the matrix by merging rows and colunms at index_2 with index_1.
  # * +index_1+ The matrix index of the first row and column to be merged.
  # * +index_2+ The matrix index of the second row and column to be merged.
  # * +matrix+ The matrix to be compressed.
  # * +matrix_index+ The index of the matrix to be compressed.
  def compress(index_1, index_2, matrix = bm, matrix_index = bmi.mi)
    new_matrix = matrix.dup
    i_1 = matrix_index.index(index_1)
    i_2 = matrix_index.index(index_2)
    a_1 = new_matrix[i_1]
    a_2 = new_matrix[i_2]
    a_c_1_2 = compress_array(a_1, a_2, i_1)
    new_matrix[i_1] = a_c_1_2
    new_matrix.delete_at(i_2)
    new_matrix_t = new_matrix.transpose.dup
    a_1_t = new_matrix_t[i_1]
    a_2_t = new_matrix_t[i_2]
    a_c_1_2_t = compress_array(a_1_t, a_2_t, i_1)
    new_matrix_t[i_1] = a_c_1_2_t
    new_matrix_t.delete_at(i_2)
    new_matrix_t.transpose.dup
  end
end
