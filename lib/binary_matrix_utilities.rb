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
        |y| matrix[x][y] > 1 ? matrix[x][y] = 1 : matrix[x][y]
      end
    end
  end

  def id_matrix(size)
    id = Array.new(size) { Array.new(size, 0) }
    id[0][0] = 1
    (0..size - 1).map { |x| id[x][x] = 1 }
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
  
  #need to add matrix as an argument
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
  
  def swap_row_column(matrix, index_1, index_2)
    tm = matrix.dup
    i1 = index_1-1
    i2 = index_2-1
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

  def swap_index(matrix, index_1, index_2)
    tm = matrix.dup
    i1 = index_1-1
    i2 = index_2-1
    ta1 = tm[i1]
    ta2 = tm[i2]
    tm[i1] = ta2
    tm[i2] = ta1 
    tm
  end  

  def reachability_matrix(matrix)
    tmp_matrix = matrix.dup
    guard_num = 0
    check_matrix_1 = boolean_multiply(tmp_matrix, tmp_matrix)
    check_matrix_2 = boolean_multiply(check_matrix_1, check_matrix_1)
    until boolean_subtract(check_matrix_1, check_matrix_2) == 0 || guard_num > 10
      guard_num = guard_num + 1
      check_matrix_1 = boolean_multiply(check_matrix_2, check_matrix_2)
      check_matrix_2 = boolean_multiply(check_matrix_1, check_matrix_1)
    end
    matrix_out = check_matrix_2
  end  


end
