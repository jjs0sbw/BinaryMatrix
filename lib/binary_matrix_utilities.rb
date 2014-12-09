# encoding : utf-8
#
# binary_matrix_utilities.rb
# Utilities that support different output forms for a BinaryMatrix instance
#
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-23-2014
module Utilities
  def boolean_map(matrix)
    m_size = (matrix[0].length - 1)
    (0..m_size).map do
      |x| (0..m_size ).map do
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
    a_out[index_2[0]] = 0
    a_out
  end
  
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
  
  def swap_row_column(index_1, index_2, matrix = bm,  matrix_index = bmi.mi)
    tm = matrix.dup
    #i1 = bmi.mi[index_1 - 1][0] 
    #i2 = bmi.mi[index_2 - 1][0] 
    #p @binary_matrix.bmi.mi.length
    #p bmi.mi.length
    #p bmi.mi
    i1 = bmi.mi.index(index_1)
    i2 = bmi.mi.index(index_2)
    #p "The indexes are #{i1}  and #{i2}"
    #p "The indexes are #{index_1}  and #{index_2}"

    #ta1 = tm[i1 - 1] 
    #ta2 = tm[i2 - 1] 
    ta1 = tm[i1] 
    ta2 = tm[i2] 

    #tm[i1 - 1] = ta2 
    #tm[i2 - 1] = ta1 
    tm[i1] = ta2 
    tm[i2] = ta1 
    #stopped here
    tmt = tm.transpose

    #tat1 = tmt[i1 - 1] 
    #tat2 = tmt[i2 - 1] 
    tat1 = tmt[i1] 
    tat2 = tmt[i2] 
    #tmt[i1 - 1] = tat2 
    #tmt[i2 - 1] = tat1 
    tmt[i1] = tat2 
    tmt[i2] = tat1 

    tout = tmt.transpose.dup 
    matrix = tout  #added matrix =
  end 

  def swap_index(index_1, index_2, matrix_index) # moved and renamed matrix
    tm = matrix_index.dup
    #i1 = bmi.mi[index_1 - 1][0]
    #i2 = bmi.mi[index_2 - 1][0] 
    i1 = bmi.mi.index(index_1)
    i2 = bmi.mi.index(index_2)
    #ta1 = tm[i1 - 1] 
    #ta2 = tm[i2 - 1] 
    ta1 = tm[i1] 
    ta2 = tm[i2] 
    tm[i1] = ta2 
    tm[i2] = ta1 
    matrix_index = tm.dup # added dup and matrix =
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

  def subtract_id_matrix(matrix)
    sz = (matrix[0].length - 1)
    (0..sz).map { |x| matrix[x][x] = 0 }
    matrix
  end  


end
