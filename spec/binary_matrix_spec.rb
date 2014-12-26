require File.expand_path("../../lib/binary_matrix.rb", __FILE__)
require "#{File.dirname(__FILE__)}/spec_helper"
require 'logger'

describe BinaryMatrix do 
  logger = Logger.new('strict_log_two.txt')
  logger.formatter = proc do |severity, datetime, progname, msg|
    "Binary Matrix: #{msg}\n"
  end
  logger.info "\nThis is a info logging file\n"
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
      @binary_matrix.enter_cell_content([2], [5])
      expect(@binary_matrix.add).to be == 1
    end

    it "will enter a zero into the cell if the index numbers are the same" do
      @binary_matrix.enter_cell_content([2], [2], @binary_matrix.bm, @binary_matrix.bmi.mi)
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
      expect(@binary_matrix.compress([2], [6])).to eq temp_matrix_answer
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
       	log(logger, "\n Enter base binary matrix.. Strict ordering\n")
       end
    end

    describe "#enter_cell_content" do
      it "will add a one to the matrix cell" do
	enter(1, 2)
       	log(logger, "\nEnter 2 is north of 1\n")
       end
      end
  
    describe "#swap_row_column" do
      it "will swap rows and columns to create proper alignment" do
	enter(1, 2)
       	swap(1, 2)
       	log(logger, "\nSwap rows and columns 1 and 2\n")
       end
     end  

      describe "#enter_cell_content" do
        it "will add a one to the matrix cell" do
	  enter(1, 2)
       	  swap(1, 2)
       	  enter(3, 1)
       	  log(logger, "Enter 1 is north of 3\n")
         end
      end  

      describe "#reachability_matrix" do
        it "will create reachability matrix and infer information" do
          enter(1, 2)
       	  swap(1, 2)
       	  enter(3, 1)
       	  infer
       	  log(logger,  "Infer information\n")
        end
      end  
      

       describe "#enter_cell_content" do
         it "will enter a 1 into the specific cell" do
           enter(1, 2)
       	   swap(1, 2)
      	   enter(3, 1)
      	   infer
       	   enter(2, 4)
       	   log(logger,  "Enter 4 is north of 2\n")
         end
      end  

      describe "#swap_row_column" do
         it "will swap selected row and column" do
           enter(1, 2)
      	   swap(1,2)
      	   enter(3, 1)
       	   infer
       	   enter(2, 4)
      	   swap(2, 4)
      	   log(logger,  "Swap row and column 2 and 4\n")
         end
      end  

      describe "#swap_row_column" do
         it "will swap selected row and column" do
           enter(1, 2)
	   swap(1, 2)
           enter(3, 1)
           infer
           enter(2, 4)
           swap(2, 4)
           swap(1, 2)
           log(logger, "Swap row and column 1 and 2\n")
          
	 end
      end  

      describe "#swap_row_column" do
         it "will swap selected row and column" do
           enter(1, 2)
	   swap(1, 2)
           enter(3, 1)
           infer
           enter(2, 4)
           swap(2, 4)
           swap(1, 2)
	   swap(3, 1)
           log(logger, "Swap row and column 3 and 1\n")
         end
      end  

       describe "#reachability_matrix" do
         it "will create reachability_matrix and infer information" do
           enter(1, 2)
	   swap(1, 2)
           enter(3, 1)
           infer
           enter(2, 4)
           swap(2, 4)
           swap(1, 2)
	   swap(3, 1)
	   infer
           log(logger, "Infer information\n" )
         end
      end  

       
      describe "#enter_cell_content" do
         it "will enter a 1 into the proper matrix cell" do
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
           log(logger,  "Enter 5 no 3\n" )
        end
      end   

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
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
           log(logger,  "Swap row column 3 and 5\n"  )
        end
      end   


      describe "#reachability_matrix" do
         it "will create reachability matrix and infer information" do
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
	   log(logger,  "Infer information\n"   )

        end
      end   

      def part_zero
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
      end

      describe "#enter_cell_content" do
         it "will enter a 1 into the selected cell" do
           part_zero
	   enter( 5, 1)
	   log(logger,  "Enter 1 is north of 5\n"    )
        end
      end   

       describe "#reachability_matrix" do
         it "will calculate reachability_matrix and infer information" do
           part_zero
	   enter( 5, 1)
	   infer
	   log(logger,  "Infer information\n"  )
        end
      end   

       describe "#enter_cell_content" do
         it "will enter a 1 into the proper cell" do
           part_zero
	   enter( 5, 1)
	   infer
	   enter(3, 6)
	   log(logger, "Enter 6 is north of 3\n"  )
        end
      end   

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_zero
	   enter( 5, 1)
	   infer
	   enter(3, 6)
	   swap(3, 6)
	   log(logger,  "Swap row and column 3 and 6\n"  )
        end
      end   

       describe "#enter_cell_content" do
         it "will enter a 1 in the selected cell" do
           part_zero
	   enter( 5, 1)
	   infer
	   enter(3, 6)
	   swap(3, 6)
	   enter(6, 5)
	   log(logger,  "Enter 5 is north of 6\n"  )
        end
      end   

      describe "#reachability_matrix" do
         it "will calculate reachability matrix and infer information" do
           part_zero
	   enter( 5, 1)
	   infer
	   enter(3, 6)
	   swap(3, 6)
	   enter(6, 5)
	   infer
	   log(logger, "Infer information\n"  )
        end
      end   

      describe "#enter_cell_content" do
         it "will enter a 1 in the selecte matrix cell" do
           part_zero
	   enter( 5, 1)
	   infer
	   enter(3, 6)
	   swap(3, 6)
	   enter(6, 5)
	   infer
	   enter(4, 7)
	   log(logger,  "\nEnter 7 is north of 4")
        end
      end   

      describe "#swap_row_column" do
         it "will swap the selected row and column" do
           part_zero
	   enter( 5, 1)
	   infer
	   enter(3, 6)
	   swap(3, 6)
	   enter(6, 5)
	   infer
	   enter(4, 7)
	   swap(4, 7)
	   log(logger,  "\nSwap row column 4 and 7" )
        end
      end   

      def part_one
        part_zero
	enter( 5, 1)
	infer
	enter(3, 6)
	swap(3, 6)
	enter(6, 5)
	infer
	enter(4, 7)
	swap(4, 7)
      end

      describe "#swap_row_column" do
         it "will swap the selected row and column" do
           part_one
           swap(2, 4)
           swap(1, 2)
           swap(5, 1)
           swap(6, 5)
           swap(3, 6)
           log(logger,  "\nSwap row column 2 and 4, 1 and 2, 5 and 1, 6 and 5, 3 and 6" )
        end
      end   

      describe "#reachability_matrix" do
         it "will calculate the reachability matrix and infer information" do
           part_one
           swap(2, 4)
           swap(1, 2)
           swap(5, 1)
           swap(6, 5)
           swap(3, 6)
	   infer
           log(logger,  "\nInfer information" )
        end
      end   
   
      describe "#enter_cell_content" do
         it "will enter a 1 in the selected cell" do
           part_one
           swap(2, 4)
           swap(1, 2)
           swap(5, 1)
           swap(6, 5)
           swap(3, 6)
	   infer
	   enter(3, 8)
           log(logger,  "\nEnter 8 is north of 3" )
        end
      end   

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_one
           swap(2, 4)
           swap(1, 2)
           swap(5, 1)
           swap(6, 5)
           swap(3, 6)
	   infer
	   enter(3, 8)
	   swap(3, 8)
           log(logger,  "\nSwap row, column 3 and 8\n" )
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_one
           swap(2, 4)
           swap(1, 2)
           swap(5, 1)
           swap(6, 5)
           swap(3, 6)
	   infer
	   enter(3, 8)
	   swap(3, 8)
	   enter(6, 8)
           log(logger, "\nEnter 8 is north if 6" )
        end
      end    
      def part_two
         part_one
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
         it "will swap the selected rows and columns" do
           part_two
	   swap(6, 8)
           log(logger,"\nSwap rows and columns 6 and 8")
        end
      end

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
           log(logger, "\nEnter 8 is north of 5" )
        end
      end    

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
           log(logger, "\nSwap rows and columns 5 and 8" )
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 into the selected matrix cell" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
	   enter(8, 1)
           log(logger,  "\nEnter 1 is north of 8" )
        end
      end    

      describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
	   enter(8, 1)
	   infer
           log(logger,  "\nInfer information"  )
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
	   enter(8, 1)
	   infer
	   enter(3, 9)
           log(logger,  "\nEnter 9 is north of 3" )            
        end
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
           log(logger,  "\nSwap rows and columns 3 and 9" )  
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
	   enter(8, 1)
	   infer
	   enter(3, 9)
	   swap(3, 9)
	   enter(6, 9)
           log(logger,  "\nEnter 9 is north of 6" )  
        end
      end    

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
	   enter(8, 1)
	   infer
	   enter(3, 9)
	   swap(3, 9)
	   enter(6, 9)
	   swap(6, 9)
           log(logger, "\nSwap rows and columns 6 and 9" )  
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
	   swap(6, 8)
	   enter(5, 8)
	   swap(5, 8)
	   enter(8, 1)
	   infer
	   enter(3, 9)
	   swap(3, 9)
	   enter(6, 9)
	   swap(6, 9)
	   enter(9, 5)
           log(logger, "\nEnter 5 is north of 9" )  
        end
      end  

      def part_three
         part_two
	 swap(6, 8)
	 enter(5, 8)
	 swap(5, 8)
	 enter(8, 1)
	 infer
	 enter(3, 9)
	 swap(3, 9)
	 enter(6, 9)
	 swap(6, 9)
	 enter(9, 5)
      end

      describe "#reachability_matrix" do
         it "will calculate reachability_matrix and infer information" do
           part_three
	   infer
           log(logger,  "\nInfer information" )  
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 in the matrix cell" do
           part_three
	   infer
	   enter(10, 11)
           log(logger,  "\nEnter 11 is north of 10" ) 
        end
      end  

      describe "#swap_row_column" do
         it "will swap_row_column that are selected" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
           log(logger,  "\nSwap swap_row_column 10 and 11" ) 
        end
      end  

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
           log(logger,  "\nEnter 12 is north of 3" ) 
        end
      end  

      
      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
	   swap(3, 12)
           log(logger,  "\nSwap rows and columns 3 and 12" ) 
        end
      end  


      describe "#enter_cell_content" do
         it "will enter a 1 into the selected matrix cell" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
	   swap(3, 12)
	   enter(2, 11)
           log(logger,  "\nEnter 11 is north of 2" )
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
	   swap(3, 12)
	   enter(2, 11)
	   swap(2, 11)
           log(logger,  "\nSwap rows columns 2 and 11" )
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 into the selected  matrix cell" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
	   swap(3, 12)
	   enter(2, 11)
	   swap(2, 11)
	   enter(11, 4)
           log(logger, "\nEnter 4 is north of 11" )
        end
      end  

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
	   swap(3, 12)
	   enter(2, 11)
	   swap(2, 11)
	   enter(11, 4)
	   swap(10, 11)
	   swap(1, 2)
           log(logger, "\nSwap rows and columns 2 and 1")
        end
      end  

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
	   infer
	   enter(10, 11)
	   swap(10, 11)
	   enter(3, 12)
	   swap(3, 12)
	   enter(2, 11)
	   swap(2, 11)
	   enter(11, 4)
	   swap(10, 11)
	   swap(1, 2)
	   swap(10, 11)
           log(logger, "\nSwap rows and columns 10 and 11")
        end
      end  

       def part_three_five
         part_three
	 infer
	 enter(10, 11)
	 swap(10, 11)
	 enter(3, 12)
	 swap(3, 12)
	 enter(2, 11)
	 swap(2, 11)
	 enter(11, 4)
	 swap(10, 11)
	 swap(1, 2)
	 swap(10, 11)
       end

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three_five
           swap(8, 1)
	   swap(5, 8)
           log(logger, "\nSwap rows and columns 5 and 8")
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three_five
           swap(8, 1)
	   swap(5, 8)
	   swap(6, 5)
           log(logger,  "\nSwap rows and columns 6 and 5")
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three_five
           swap(8, 1)
	   swap(5, 8)
	   swap(6, 5)
	   swap(9, 5)
           log(logger,  "\nSwap rows and columns 9 and 5" )
        end
      end  

      describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_three_five
           swap(8, 1)
	   swap(5, 8)
	   swap(6, 5)
	   swap(9, 5)
	   infer
           log(logger, "\nInfer information" )
        end
      end  

      def part_four
        part_three_five
        swap(8, 1)
	swap(5, 8)
	swap(6, 5)
	swap(9, 5)
	infer
      end

       describe "#enter_cell_content" do
         it "will enter a 1 into the selected matrix cell" do
           part_four
           enter(1, 10)
	   log(logger,  "\nEnter 10 is north of 1")
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   log(logger,  "\nSwap rows and columns 1 and 10")
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   log(logger,  "\nSwap rows and columns 8 and 1" )
       end
      end  

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   swap(5, 8)
	   log(logger, "\nSwap rows and columns 5 and 8"  )
	 end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   swap(5, 8)
	   swap(9, 5)
	   log(logger,  "\nSwap rows and columns 9 and 5" )
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   swap(5, 8)
	   swap(9, 5)
	   swap(6, 9)
	   log(logger,"\nSwap rows and columns 6 and 9" )
        end
      end  


      describe "#reachability_matrix" do
         it "will calculate reachability_matrix and infer information" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   swap(5, 8)
	   swap(9, 5)
	   swap(6, 9)
	   infer
	   log(logger,  "\nInfer information" )
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 into the matrix cell" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   swap(5, 8)
	   swap(9, 5)
	   swap(6, 9)
	   infer
	   enter(1, 12)
	   log(logger, "\nEnter 12 is north of 1" )
        end
      end  

      describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_four
           enter(1, 10)
	   swap(1, 10)
	   swap(8, 1)
	   swap(5, 8)
	   swap(9, 5)
	   swap(6, 9)
	   infer
	   enter(1, 12)
	   swap(1, 12)
	   log(logger,  "\nSwap rows and columns 12 and 1" )
        end
      end  

      def part_five
         part_four
         enter(1, 10)
	 swap(1, 10)
	 swap(8, 1)
	 swap(5, 8)
	 swap(9, 5)
	 swap(6, 9)
	 infer
	 enter(1, 12)
	 swap(1, 12)
      end

       describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_five
	   swap(8, 1)
           log(logger, "\nSwap rows and columns 1 and 8" )
        end
      end  

       describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_five
	   swap(8, 1)
	   swap(5, 8)
           log(logger, "\nSwap rows and columns 8 and 5" )
        end
      end  

       describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_five
	   swap(8, 1)
	   swap(5, 8)
	   infer
           log(logger, "\nInfer information" )
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_five
	   swap(8, 1)
	   swap(5, 8)
	   infer
	   enter(12, 10)
           log(logger,  "\nEnter 10 is  north of 12" )
        end
      end  


       describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_five
	   swap(8, 1)
	   swap(5, 8)
	   infer
	   enter(12, 10)
	   infer
           log(logger,  "\nInfer information" )
       end
      end   
end  











