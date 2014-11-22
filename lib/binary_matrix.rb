require "#{File.dirname(__FILE__)}/binary_matrix/version"

class BinaryMatrix
  attr_accessor :size

  def initialize size
    @size = size
  end

end
