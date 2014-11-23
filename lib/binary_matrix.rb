require "#{File.dirname(__FILE__)}/binary_matrix/version"

class BinaryMatrix
  attr_accessor :size, :number_of_rows, :number_of_columns, :bm

  def initialize size
    @size = size
    @number_of_rows = size
    @number_of_columns = size
    @bm = Array.new(size) { Array.new(size, 0) }
  end

end
