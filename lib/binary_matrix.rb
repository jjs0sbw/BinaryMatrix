require "#{File.dirname(__FILE__)}/binary_matrix/version"

class BinaryMatrix
  attr_accessor :size, :number_of_rows

  def initialize size
    @size = size
    @number_of_rows = size
  end

end
