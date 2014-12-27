require File.expand_path("../../lib/binary_matrix.rb", __FILE__)
require "#{File.dirname(__FILE__)}/spec_helper"
require 'logger'

describe BinaryMatrix do 
  logger = Logger.new('general_log_one.txt')
  logger.formatter = proc do |severity, datetime, progname, msg|
    "Binary Matrix: #{msg}\n"
  end
  logger.info "\nThis is a info logging file for the general subordination matrix\n"
  before :each do
    @binary_matrix = BinaryMatrix.new(12)
  end

  def compress(x, y)
     @binary_matrix.bm = @binary_matrix.compress([x], [y])
     @binary_matrix.bmi.mi = @binary_matrix.bmi.compress_index(x, y)

  end
 
  def enter(x, y)
    @binary_matrix.enter_cell_content(x, y, 1, @binary_matrix.bm)

  end

  def swap(x, y)
    @binary_matrix.bm = @binary_matrix.swap_row_column(x, y, @binary_matrix.bm, @binary_matrix.bmi.mi)
    @binary_matrix.bmi.mi = @binary_matrix.swap_index(x, y, @binary_matrix.bmi.mi)
  end

  def infer
    @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
    @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
  end

  def log(logger, message)
	puts message
        puts @binary_matrix.bm.to_a.map(&:inspect)
        puts "Matrix Index .. \n"
        p @binary_matrix.bmi.mi.to_a.map(&:inspect)
	logger.info message
        "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
        logger.info "\n\nMatrix Index"
        logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
  end

  describe "#new" do
    it "takes one parameter and returns a BinaryMatrix object" do
      expect(@binary_matrix).to be_a_kind_of(BinaryMatrix)
    end

    it "has a size of tweleve (12)" do
      expect(@binary_matrix.size).to be == 12
    end

    it "has tweleve (12) rows in the matrix" do
      expect(@binary_matrix.number_of_rows).to be == 12
    end

    it "has tweleve (12) columns in the matrix" do
      expect(@binary_matrix.number_of_columns).to be == 12
    end

    it "has a two dimensional tweleve (12) by tweleve (12) array" do
      expect(@binary_matrix.bm).to be_a_kind_of(Array)
    end

    it "bm array is filled with zeros" do
      expect(@binary_matrix.add(@binary_matrix.bm)).to be == 0
    end

    it "has an matrix index" do
      expect(@binary_matrix.bmi).to be_a_kind_of(MatrixIndex)
    end
  end 

  describe "#add" do
      it "will add up all the values in a matrix" do
      temp_matrix = Array.new(4) { Array.new(4, 1)}
      expect(@binary_matrix.add(temp_matrix)).to be == 16
    end
  end

  describe "#enter_cell_content" do

    it "will enter a one (1) into a matrix cell" do
      enter([2], [5])
      #@binary_matrix.enter_cell_content([2], [5])
      expect(@binary_matrix.add).to be == 1
    end

    it "will enter a zero into the cell if the index numbers are the same" do
      enter([2], [2])
      #@binary_matrix.enter_cell_content([2], [2])
      expect(@binary_matrix.add).to be == 0
    end

  end  

  describe "#boolean_add" do
    it "will add cell contents from two same size matrices" do
      temp_matrix_1 = Array.new(10) { Array.new(10, 1) }
      temp_matrix_2 = Array.new(10) { Array.new(10, 2) }
      temp_matrix_out = Array.new(10) { Array.new(10, 0) }
      temp_matrix_answer = Array.new(10) { Array.new(10, 1) }
      temp_matrix_out = @binary_matrix.boolean_add(temp_matrix_1, temp_matrix_2)
      expect(temp_matrix_out).to eq temp_matrix_answer
    end
  end

  describe "#boolean_multiply" do
    it "will multipley two square matrices together and return a Boolean matrix" do
      temp_matrix_1 = Array.new(10) { Array.new(10, 0) }
      temp_matrix_2 = Array.new(10) { Array.new(10, 0) }
      temp_matrix_a1 = Array.new(10) { Array.new(10, 0) }
      temp_matrix_a2 = @binary_matrix.id_matrix(10)
      temp_matrix_answer = @binary_matrix.boolean_add(temp_matrix_a1, temp_matrix_a2)
      temp_matrix_out = @binary_matrix.boolean_multiply(temp_matrix_1, temp_matrix_2)
      expect(temp_matrix_out).to eq temp_matrix_answer
    end
  end

  describe "#expand_end" do
    it "will expand the matrix by one row and column at the end" do
      temp_matrix_answer = Array.new(13) { Array.new(13, 0) }
      expect(@binary_matrix.expand_end(@binary_matrix.bm)).to eq temp_matrix_answer
    end
  end

  describe "#expand" do
    it "will expand the matrix inserting a row and column at the given index " do
      temp_matrix_answer = Array.new(13) { Array.new(13, 0) }
      expect(@binary_matrix.expand(@binary_matrix.bm, 4)).to eq temp_matrix_answer
    end
  end

  describe "#compress" do
    it "will compress two rows and columns into one" do
      temp_matrix_answer = Array.new(11) { Array.new(11, 0) }
      expect(@binary_matrix.compress([2], [6])).to eq temp_matrix_answer # added brackets
    end
  end

  describe "#square_print_with_comment" do
    it "will print the matrix in a square format with a commnet" do
      expect { print "test one" }.to output("test one").to_stdout
    end
    it "will print the matrix in a square format with a commnet" do
      expect { @binary_matrix.square_print_with_comment("testOne", \
        @binary_matrix.bm)}.to output("  \ntestOne
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  \n").to_stdout
    end
  end 

   describe "#write_log" do
      it "will log the matrix in a square format with a comment to a local file" do
	log(logger, "\n Binary Matrix .. General\n")      
      end
    end
    
    # 1 and 10 were randomly selected to as the first set to compare
    # City 1 and city 10 are at the same level, so the rows and columns must be merged
    describe "#compress" do
      it "will compress two rows and columns into one" do
	compress(1, 10)
       	log(logger,  "Compress rows columns 1 and 10\n")
       end
      end

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
	compress(1, 10)      
       	enter([1, [10]], [8])
       	log(logger,  "Enter 8 is north of 1\n")
      end
      end

      describe "#swap_row_column" do
      it "will swap selected rows and columns to create proper alignment" do
	compress(1, 10)
       	enter([1, [10]], [8])
	swap([1, [10]], [8])
       	log(logger,  "Swap rows and columns 1 and 8")
      end
      end

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        compress(1, 10)
       	enter([1, [10]], [8])
	swap([1, [10]], [8])
	enter([12], [8])
       	log(logger,  "Enter 8 is north of 12" )
        end
      end

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        compress(1, 10)
       	enter([1, [10]], [8])
	swap([1, [10]], [8])
	enter([12], [8])
	enter([12], [5])
       	log(logger,  "Enter 5 is north of 12" )
        end
      end

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        compress(1, 10)
       	enter([1, [10]], [8])
	swap([1, [10]], [8])
	enter([12], [8])
	enter([12], [5])
	enter([3], [5])
       	log(logger, "Enter 5 is north of 3" )
        end
      end
          
      describe "#swap_row_column" do
      it "will swap the selected rows and columns" do
        compress(1, 10)
       	enter([1, [10]], [8])
	swap([1, [10]], [8])
	enter([12], [8])
	enter([12], [5])
	enter([3], [5])
	swap([3], [5])
       	log(logger, "Swap row column 3 and 5" )
        end
      end    

      def part_one
        compress(1, 10)
       	enter([1, [10]], [8])
	swap([1, [10]], [8])
	enter([12], [8])
	enter([12], [5])
	enter([3], [5])
	swap([3], [5])
      end
          

      describe "#enter_cell_content" do
      it "will place a one in the selected matrix cell" do
        part_one
	enter([4], [3])
	log(logger, "Enter 3 is north of 4")
      end
      end      

      
      describe "#swap_row_column" do
      it "will swap the selected row and column" do
        part_one
	enter([4], [3])
	swap([4], [3])
	log(logger, "Swap row column 4 and 3")
        end
      end     


      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	log(logger,  "Enter 7 is north of 4")
        end
      end            

      describe "#swap_row_column" do
      it "will swap the selected rows and columns" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	log(logger, "Swap rows and columns 4 and 7")
        end
      end     


      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	enter([7], [11])
	log(logger,  "Enter 11 is north of 7")
        end
      end                               
            
      describe "#swap_row_column" do
      it "will swap the selected matrix cell" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	enter([7], [11])
	swap([7],[11])
	log(logger, "Swap rows columns 11 and 7" )
      end
      end              

      describe "#swap_row_column" do
      it "will swap the selected matrix cell" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	enter([7], [11])
	swap([7],[11])
	swap([4], [11])
	log(logger, "Swap rows columns 11 and 4")
        end
      end  

      describe "#swap_row_column" do
      it "will swap the selected matrix cell" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	enter([7], [11])
	swap([7],[11])
	swap([4], [11])
	swap([4], [7])
	log(logger, "Swap rows columns 7 and 4" )
        end
      end      

      describe "#swap_row_column" do
      it "will swap the selected matrix cell" do
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	enter([7], [11])
	swap([7],[11])
	swap([4], [11])
	swap([4], [7])
	swap([7], [11])
	log(logger,  "Swap rows columns 11 and 7" )
        end
      end                                                                                                                                                                                                                                                                                            
                                      
      def part_two
        part_one
	enter([4], [3])
	swap([4], [3])
	enter([4], [7])
	swap([4], [7])
	enter([7], [11])
	swap([7],[11])
	swap([4], [11])
	swap([4], [7])
	swap([7], [11])
      end                                
      

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_two
	enter([6], [11])
	infer
       	log(logger,  "Enter 11 is north of 6" )
        end
      end          

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_two
	enter([6], [11])
	infer
	enter([6], [9])
	swap([6], [9])
	infer
       	log(logger,"Enter 9 is north of 6 and process" )
        end
      end                                                                                                                                      

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_two
	enter([6], [11])
	infer
	enter([6], [9])
	swap([6], [9])
	infer
	enter([9], [2])
	infer
       	log(logger, "Enter 2 is north of 9 and process" )
        end
      end    

      def part_three
        part_two
	enter([6], [11])
	infer
	enter([6], [9])
	swap([6], [9])
	infer
	enter([9], [2])
	infer
      end

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_three
	enter([2], [8])
	infer
        log(logger, "Enter 2 is north of 8 and process" )
        end
      end   

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_three
	enter([2], [8])
	infer
	enter([5], [2])
	infer
        log(logger,  "Enter 2 is north of 5 and process")
        end
      end    

      describe "#compress" do
      it "will compress row columns 5 and 11 into row columns 5" do
        part_three
	enter([2], [8])
	infer
	enter([5], [2])
	infer
	compress(5, 11)
	infer
        log(logger,  "Compress 5 and 11 into 5 and process")
        end
      end      

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        part_three
	enter([2], [8])
	infer
	enter([5], [2])
	infer
	compress(5, 11)
	infer
	enter([1,[10]], [2])
	infer
        log(logger,  "Enter 2 is north of 1-10 and process" )
        end
      end      

      def part_four
        part_three
	enter([2], [8])
	infer
	enter([5], [2])
	infer
	compress(5, 11)
	infer
	enter([1,[10]], [2])
	infer
      end

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        part_four
        enter([9], [3])
	infer
        log(logger,  "Enter 3 is north of 9 and process" )
        end
      end      

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
        log(logger, "Enter 3 is north of 7" )
        end
      end      

      describe "#enter_cell_content" do
      it "will enter a 1 into the selected matrix cell" do
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
	enter([7], [9])
        log(logger,  "Enter 9 is north of 7" )
        end
      end      

      describe "#compress" do
      it "will compress row columns 3 and 6 into 3" do
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
	enter([7], [9])
	compress(3, 6)
        log(logger,  "Compress 3 and 6 into 3"  )
        end
      end      

      describe "#swap_row_column" do
      it "will swap_row_column 1-10 and 3-6 " do
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
	enter([7], [9])
	compress(3, 6)
	swap([1, [10]], [3, [6]])
        log(logger,  "Swap rows columns 1-10 and 3-6" )
      end
      end     

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
	enter([7], [9])
	compress(3, 6)
	swap([1, [10]], [3, [6]])
	enter([9], [3, [6]])
        log(logger,  "Enter 3-6 is north of 9"  )
        end
      end       
  
      describe "#swap_row_column" do
      it "will swap rows and column 3-6 and 9" do
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
	enter([7], [9])
	compress(3, 6)
	swap([1, [10]], [3, [6]])
	enter([9], [3, [6]])
	swap([9], [3, [6]])
        log(logger, "Enter 3-6 is north of 9" )
        end
      end     

      def part_five  
        part_four
        enter([9], [3])
	infer
	enter([7], [3])
	enter([7], [9])
	compress(3, 6)
	swap([1, [10]], [3, [6]])
	enter([9], [3, [6]])
	swap([9], [3, [6]])
      end
    
      describe "#compress" do
      it "will compress rows and columns 9 and 12" do
        part_five
	compress(9, 12)
        log(logger, "Compress row and columns 9 and 12" )
        end
      end     

      describe "#enter_cell_content" do
      it "will enter a 1 in the selected matrix cell" do
        part_five
	compress(9, 12)
	enter([7], [9,[12]])
	swap([7], [9, [12]])
        log(logger,  "Enter 9-12 north of 7")
        end
      end     


end
