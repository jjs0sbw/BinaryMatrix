require "#{File.dirname(__FILE__)}/binary_matrix/version"
require "#{File.dirname(__FILE__)}/matrix_index"
require "#{File.dirname(__FILE__)}/binary_matrix_utilities"
require "#{File.dirname(__FILE__)}/log_and_print"

# Binary matrix class for Warfield Augumented Boolean Logic
class BinaryMatrix
  include Utilities
  include LogAndPrint
  attr_accessor :size, :number_of_rows, :number_of_columns, :bm, :bmi

  def initialize(size)
    @size = size
    @number_of_rows = size
    @number_of_columns = size
    @bm = Array.new(size) { Array.new(size, 0) }
    @bmi = MatrixIndex.new(size)
  end

  def add(matrix = bm)
    sum = 0
    matrix.each { |x| x.each { |y| sum += y } }
    sum
  end

  def enter_cell_content(index_1, index_2, number = 1, matrix = bm, matrix_in = bmi.mi)
    number = 0 if index_1 == index_2
    r_1 = matrix_in.index(index_1)
    r_2 = matrix_in.index(index_2)
    matrix[r_1][r_2] = number
    matrix
  end

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

  def expand(matrix, index_1)
    new_matrix = expand_end(matrix)
    last_index = new_matrix[0].length - 1
    matrix_out = swap_row_column([index_1], [last_index], new_matrix)
    matrix_out
  end

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
