require "#{File.dirname(__FILE__)}/binary_matrix/version"
require "#{File.dirname(__FILE__)}/matrix_index"

class BinaryMatrix
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
    new_matrix = @bm.dup
    t_nm = new_matrix.transpose
    t_nm.dup
  end  

  def boolean_add(matrix_one, matrix_two)
    t_matrix_one = matrix_one.dup
    t_matrix_two = matrix_two.dup
    #check for same size square matices
    size = t_matrix_two.length  
    t_matrix_out = Array.new(size) { Array.new(size, 0) }
    (0..(size-1)).map do | x|
      (0..(size-1)).map do |y|
        t_matrix_out[x][y] = (t_matrix_one[x][y] + t_matrix_two[x][y])
      end
    end
      
  end

end
