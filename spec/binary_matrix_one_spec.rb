describe BinaryMatrix do 
  logger = Logger.new('strict_log_one.txt')
  logger.formatter = proc do |severity, datetime, progname, msg|
    "Binary Matrix: #{msg}\n"
  end
  logger.info "\nThis is a info logging file -- Strict - One\n"

  before :each do
    @binary_matrix = BinaryMatrix.new(12)
  end

  def enter(x, y)
    @binary_matrix.enter_cell_content([x], [y], 1, @binary_matrix.bm)

  end

  def swap(x, y)
    @binary_matrix.bm = @binary_matrix.swap_row_column([x], [y], @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index([x], [y], @binary_matrix.bmi.mi)
  end

  def infer
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
  end

  def part_two
    enter(1, 2)
    swap(1, 2)
    enter(3, 1)
    infer
    enter(2, 4)
    swap(2, 4)
    swap(1, 2)
    swap(3, 1)
    infer
    enter(3, 5)
    swap(3, 5)
    infer
    enter(5, 1)
    infer
    enter(3, 6)
    swap(3, 6)
    enter(6, 5)
    infer
    enter(4, 7)
    swap(4, 7)
    swap(2, 4)
    swap(1, 2)
    swap(5, 1)
    swap(6, 5)
    swap(3, 6)
    infer
    enter(3, 8)
    swap(3, 8)
    enter(6, 8)
  end

    describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_two
	   swap(6, 8)
      	   enter(5, 8)
      	   swap(5, 8)
       	   enter(8, 1)
      	   infer
      	   enter(3, 9)
      	   swap(3, 9)
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
