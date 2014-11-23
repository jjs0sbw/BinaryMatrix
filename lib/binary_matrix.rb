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


end
