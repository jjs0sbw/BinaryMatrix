# encoding : utf-8
#
# Utilities that support logging and printing
#
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-27-2014
# binary_matrix implements a binary matrix that supports Warfields Augumented Boolean Logic.  
# See http://systemsconcept.org for details.
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

# code to create log file
module LogAndPrint
  def  square_print_with_comment(comment, matrix = bm)
    puts '  '
    puts comment
    puts matrix.to_a.map(&:inspect)
    puts '  '
  end

  def write_log(log_name, data)
    File.open(log_name, 'a+') { |f| f.write(data)  }
  end
end
