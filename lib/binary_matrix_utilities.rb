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
        |y| if matrix[x][y] > 1
              matrix[x][y] = 1
        end
    end 
  end 
end  

end