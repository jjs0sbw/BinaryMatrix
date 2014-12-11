# encoding : utf-8
#
# An index of a binary matrix
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-22-2014
# binary_matrix implements a binary matrix that supports Warfields Augumented Boolean Logic.  See http://systemsconcept.org for details.
#     Copyright (C) 2014  Joseph James Simpson

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.
# =Matrix index class represents a matrix index
class MatrixIndex
  # Accessor items
  attr_accessor :mi
  # Initialize a MatrixIndex of size size
  # * +size+  The length of the matrix index
  def initialize(size)
    @mi = Array.new(size) { |i| Array.new(1, i + 1) }
  end
  
  # Compress the matrix index
  # * +index_1+ The index to accept new data
  # * +index_2+  The index that is deleted after data transfer
  def compress_index(index_1, index_2)
    temp_mi = mi.dup
    i1 = temp_mi.index([index_1])
    i2 = temp_mi.index([index_2])
    temp_mi[i1].push(temp_mi[i2])
    temp_mi.delete_at(i2)
    mi = temp_mi
    mi
  end
end
