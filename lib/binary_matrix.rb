b =require "#{File.dirname(__FILE__)}/binary_matrix/version"
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

  def enter_cell_content(index_1, index_2, number = 1, matrix = bm, matrix_index = bmi.mi)
    number = 0 if index_1 == index_2
    #p bmi.mi
    #p matrix_index
    #r_1_i = bmi.mi.assoc(index_1)
    #r_2_i= bmi.mi.assoc(index_2)
    #r_1 = r_1_i[0] - 1
    #r_2 = r_2_i[0] - 1
    r_1 = bmi.mi.index(index_1)
    r_2 = bmi.mi.index(index_2)
    #ti_1 = bmi.mi[index_1 - 1][0] # added [0]
    #ti_2 = bmi.mi[index_2 - 1][0]
    #ni_1 = ti_1 - 1
    #ni_2 = ti_2 - 1
    #puts " length is #{bmi.mi.length }\n" 
    #puts "bmi is  #{bmi.mi[0]}   #{bmi.mi[1]}   #{bmi.mi[2]} #{bmi.mi[6]}   #{bmi.mi[7]}   #{bmi.mi[8]}  #{bmi.mi[9]}   #{bmi.mi[10]}   #{bmi.mi[11]}  "
    #puts " The indexes -1- are #{r_1 } and #{r_2}"
    #matrix[ti_1[0]][ti_2[0]] = number
    #puts " The indexes -2- are #{[ni_1][0] } and #{[ni_2][0]} and #{ti_2 - 1} and #{ni_2}"
    #matrix[ni_1[0]][ni_2[0]] = number
    # " The indexes -3- are #{[ni_1][0] } and #{[ni_2][0]}"
    #n_1 = [ni_1][0]
    #in_2 = [ni_2][0]
    #matrix[in_1][in_2] = number
    #puts " The matrix cell  -4- is #{matrix[r_1][r_2] }"
    matrix[r_1][r_2] = number
    matrix # return matrix

  end

  #def transpose(matrix = bm)
  #  new_matrix = matrix.dup
  #  t_nm = new_matrix.transpose
  #  t_nm.dup
  #end

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
    new_matrix = self.expand_end(matrix)
    last_index = new_matrix[0].length - 1
    matrix_out = self.swap_row_column(new_matrix, index_1, last_index )
    matrix_out
  end

  def compress(index_1, index_2)
    new_matrix = bm.dup 
    i_1 = bmi.mi[index_1]
    i_2 = bmi.mi[index_2]
    a_1 = new_matrix[i_1[0]]
    a_2 = new_matrix[i_2[0]]
    a_c_1_2 = compress_array(a_1, a_2, i_2[0])
    new_matrix[i_1[0]] = a_c_1_2
    new_matrix.delete_at(i_2[0])
    new_matrix_t = new_matrix.transpose.dup
    a_1_t = new_matrix_t[i_1[0]]
    a_2_t = new_matrix_t[i_2[0]]
    a_c_1_2_t = compress_array(a_1_t, a_2_t, i_2[0])
    new_matrix_t[i_1[0]] = a_c_1_2_t
    new_matrix_t.delete_at(i_2[0])
    bm = new_matrix_t.transpose.dup 
  end
end
