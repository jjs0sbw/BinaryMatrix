describe BinaryMatrix do 
  logger = Logger.new('strict_log_one.txt')
  logger.formatter = proc do |severity, datetime, progname, msg|
    "Binary Matrix: #{msg}\n"
  end
  logger.info "\nThis is a info logging file -- Strict - One\n"

  before :each do
    @binary_matrix = BinaryMatrix.new(14)
  end

  def part_two
    @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
    @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
    @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
    @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
    @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
    @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
    @binary_matrix.enter_cell_content([6], [5], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
    @binary_matrix.enter_cell_content([4], [7], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.swap_row_column([4], [7], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([4], [7], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
    @binary_matrix.enter_cell_content([3], [8], 1, @binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.swap_row_column([3], [8], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [8], @binary_matrix.bmi.mi)
    @binary_matrix.enter_cell_content([6], [8], 1, @binary_matrix.bm)
  end

    describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8], @binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8], @binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [9], @binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [9], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 3 and 9"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 3 and 9"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

end      