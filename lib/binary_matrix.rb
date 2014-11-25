require "#{File.dirname(__FILE__)}/binary_matrix/version"
require "#{File.dirname(__FILE__)}/matrix_index"
require "#{File.dirname(__FILE__)}/binary_matrix_utilities"

class BinaryMatrix
  include Utilities
  attr_accessor :size, :number_of_rows, :number_of_columns, :bm, :bmi

  def initialize size
    @size = size
    @number_of_rows = size
    @number_of_columns = size
    @bm = Array.new(size) { Array.new(size, 0) }
    @bmi = MatrixIndex.new(size)
  end

  def add(matrix = bm)
    sum = 0
    matrix.each {|x| x.each { |y| sum = sum + y} }
    sum
  end

  def enter_cell_content(index_1, index_2, number = 1, matrix = bm)
    if index_1 == index_2
      number = 0
    end
    ti_1 = @bmi.mi.index([index_1])
    ti_2 = @bmi.mi.index([index_2])
    matrix[ti_1][ti_2] = number
  end

  def transpose(matrix = bm)
    new_matrix = matrix.dup
    t_nm = new_matrix.transpose
    t_nm.dup
  end  

  def boolean_add(matrix_one, matrix_two)
    temp_matrix_one = matrix_one.dup
    temp_matrix_two = matrix_two.dup
    #check for same size square matices
    size = temp_matrix_two[0].length 
    sz = size - 1 
    temp_matrix_out = Array.new(size) { Array.new(size, 0) }
    (0..sz).map do | x|
      (0..sz).map do |y|
        temp_matrix_out[x][y] = (temp_matrix_one[x][y] + temp_matrix_two[x][y])
      end
    end 
    boolean_map(temp_matrix_out)
    temp_matrix_out
  end

  def boolean_multiply(matrix_one, matrix_two) #includes id matrix
    size = matrix_one[0].length
    sz = size - 1
    id_1 = id_matrix(size).dup
    id_2 = id_matrix(size).dup
    m_1 = boolean_add(id_1, matrix_one.dup)
    m_2 = boolean_add(id_2, matrix_two.dup)
    m_2_t = m_2.transpose
    b_m_out = (0..sz).map { |j| (0..sz).map { |i| m_1[j].zip(m_2_t[i]).map { |x, y| x * y }.inject(:+) } }
    boolean_map(b_m_out)
    b_m_out
  end

  def expand
    new_size = size + 1
    new_row = Array.new(@size, 0)
    new_matrix = bm.dup
    new_matrix << new_row
    new_column = Array.new(new_size, 0)
    new_matrix_t = new_matrix.transpose.dup
    new_matrix_t << new_column
    bm = new_matrix_t.transpose.dup
  end

  def compress(index_1, index_2)
    new_matrix = bm.dup
    a_1 = new_matrix[index_1]
    a_2 = new_matrix[index_2]
    a_c_1_2 = compress_array(a_1, a_2, index_2)
    new_matrix[index_1] = a_c_1_2
    new_matrix.delete_at(index_2)
    new_matrix_t = new_matrix.transpose.dup
    a_1_t = new_matrix_t[index_1]
    a_2_t = new_matrix_t[index_2]
    a_c_1_2_t = compress_array(a_1_t, a_2_t, index_2)
    new_matrix_t[index_1] = a_c_1_2_t
    new_matrix_t.delete_at(index_2)
    bm = new_matrix_t.transpose
  end


end





