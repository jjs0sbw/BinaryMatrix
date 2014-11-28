# encoding : utf-8
#
# Utilities that support logging and printing 
#
# Copyright GPL 3 -- Joseph J. Simpson -- 2014 11-27-2014

module LogAndPrint
  def  square_print_with_comment(comment, matrix = bm)
    puts '  '
    puts comment
    puts matrix.to_a.map(&:inspect)
    puts '  '
  end
end
