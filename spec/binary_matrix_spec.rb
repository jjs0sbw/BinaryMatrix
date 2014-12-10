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
    @binary_matrix = BinaryMatrix.new(14)
  end
  describe "#new" do
    it "takes one parameter and returns a BinaryMatrix object" do
      expect(@binary_matrix).to be_a_kind_of(BinaryMatrix)
    end

    it "has a size of tweleve (14)" do
      expect(@binary_matrix.size).to be == 14
    end

    it "has tweleve (14) rows in the matrix" do
      expect(@binary_matrix.number_of_rows).to be == 14
    end

    it "has tweleve (14) columns in the matrix" do
      expect(@binary_matrix.number_of_columns).to be == 14
    end

    it "has a two dimensional tweleve (14) by tweleve (14) array" do
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

#describe "#transpose" do
#    it "will transpose the matrix contents" do
#      temp_matrix = Array.new(5) { Array.new(5, 0) }
#      @binary_matrix.enter_cell_content(1, 2)
#      @binary_matrix.enter_cell_content(3, 1)
#      t_matrix = @binary_matrix.transpose(@binary_matrix.bm)
#      expect(@binary_matrix.transpose(@binary_matrix.bm)).to eq t_matrix
#    end
#  end

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
      temp_matrix_answer = Array.new(15) { Array.new(15, 0) }
      expect(@binary_matrix.expand_end(@binary_matrix.bm)).to eq temp_matrix_answer
    end
  end

  describe "#expand" do
    it "will expand the matrix inserting a row and column at the given index " do
      temp_matrix_answer = Array.new(15) { Array.new(15, 0) }
      expect(@binary_matrix.expand(@binary_matrix.bm, 4)).to eq temp_matrix_answer
    end
  end

  describe "#compress" do
    it "will compress two rows and columns into one" do
      temp_matrix_answer = Array.new(13) { Array.new(13, 0) }
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
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  \n").to_stdout
    end
  end
    describe "#write_log" do
      it "will log the matrix in a square format with a comment to a local file" do
        puts "\n Binary Matrix .. Strict Ordering\n"
        puts @binary_matrix.bm.to_a.map(&:inspect)
        puts "Matrix Index .. \n"
        p @binary_matrix.bmi.mi.to_a.map(&:inspect)
        logger.info "\n Enter base binary matrix.. Strict ordering\n"
        "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
        logger.info "\n\nMatrix Index"
        "#{@binary_matrix.bmi.mi.to_a{ logger.info inspect } }"
      end
    end

    describe "#enter_cell_content" do
      it "will add a one to the matrix cell" do
        @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
        puts "Enter 2 is north of 1\n"
        puts @binary_matrix.bm.to_a.map(&:inspect)
        puts "Matrix Index .. \n"
        p @binary_matrix.bmi.mi.to_a.map(&:inspect)
        logger.info "\nEnter 2 is north of 1\n"
        "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
        logger.info "\n\nMatrix Index"
        logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end
  
    describe "#swap_row_column" do
      it "will swap rows and columns to create proper alignment" do
        @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
        puts "Swap rows and columns 1 and 2\n"
        puts @binary_matrix.bm.to_a.map(&:inspect)
        puts "Matrix Index .. \n"
        p @binary_matrix.bmi.mi.to_a.map(&:inspect)
        logger.info "\nSwap rows and columns 1 and 2\n"
        "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
        logger.info "\n\nMatrix Index"
        logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#enter_cell_content" do
        it "will add a one to the matrix cell" do
          @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
          @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
          @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
          @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
          puts "Enter 1 is north of 3\n"
          puts @binary_matrix.bm.to_a.map(&:inspect)
          puts "Matrix Index .. \n"
          p @binary_matrix.bmi.mi.to_a.map(&:inspect)
          logger.info "\nEnter 1 is north of 3\n"
          "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
          logger.info "\n\nMatrix Index"
          logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#reachability_matrix" do
        it "will create reachability matrix and infer information" do
          @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
          @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
          @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
          @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
          @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
          @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
          puts "Infer information\n"
          puts @binary_matrix.bm.to_a.map(&:inspect)
          puts "Matrix Index .. \n"
          p @binary_matrix.bmi.mi.to_a.map(&:inspect)
          logger.info "\nInfer information\n"
          "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
          logger.info "\n\nMatrix Index"
          logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  
      

       describe "#enter_cell_content" do
         it "will enter a 1 into the specific cell" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           puts "Enter 4 is north of 2\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 4 is north of 2\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap selected row and column" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           puts "Swap row and column 2 and 4\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row and column 2 and 4\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap selected row and column" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           puts "Swap row and column 1 and 2\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row and column 1 and 2\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap selected row and column" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           puts "Swap row and column 3 and 1\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row and column 3 and 1\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#reachability_matrix" do
         it "will create reachability_matrix and infer information" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "Infer information\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       
      describe "#enter_cell_content" do
         it "will enter a 1 into the proper matrix cell" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           puts "Enter 5 no 3\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 5 no 3\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           
           puts "Swap row column 3 and 5\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row column 3 and 5\n"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   


      describe "#reachability_matrix" do
         it "will create reachability matrix and infer information" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "Infer information\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#enter_cell_content" do
         it "will enter a 1 into the selected cell" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           puts "Enter 1 is north of 5\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 1 is north of 5"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

       describe "#reachability_matrix" do
         it "will calculate reachability_matrix and infer information" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "Infer information\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

       describe "#enter_cell_content" do
         it "will enter a 1 into the proper cell" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
           puts "Enter 6 is north of 3\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 6 is north of 3"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi,)
           puts "Swap row and column 3 and 6\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row and column 3 an d6"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

       describe "#enter_cell_content" do
         it "will enter a 1 in the selected cell" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([6], [5], 1, @binary_matrix.bm)
           puts "Enter 5 is north of 6\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 5 is north of 6"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#reachability_matrix" do
         it "will calculate reachability matrix and infer information" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([6], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "Infer information\n"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#enter_cell_content" do
         it "will enter a 1 in the selecte matrix cell" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([6], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([4], [7], 1, @binary_matrix.bm)
           puts "\nEnter 7 is north of 4"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 7 is north of 4"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#swap_row_column" do
         it "will swap the selected row and column" do
           @binary_matrix.enter_cell_content([1], [2], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi,)
           @binary_matrix.enter_cell_content([6], [5], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([4], [7], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([4], [7],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([4], [7], @binary_matrix.bmi.mi)
           puts "\nSwap row column 4 and 7"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row column 4 and 7"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      def part_one
        @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([3], [1], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([2], [4], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [1], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([3], [5], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [5], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([5], [1], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([3], [6], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi,)
        @binary_matrix.enter_cell_content([6], [5], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([4], [7], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([4], [7],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([4], [7], @binary_matrix.bmi.mi)
      end

      describe "#swap_row_column" do
         it "will swap the selected row and column" do
           part_one
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
           puts "\nSwap row column 2 and 4, 1 and 2, 5 and 1, 6 and 5, 3 and 6"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row column 2 and 4, 1 and 2, 5 and 1, 6 and 5, 3 and 6"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

      describe "#reachability_matrix" do
         it "will calculate the reachability matrix and infer information" do
           part_one
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   
   
      describe "#enter_cell_content" do
         it "will enter a 1 in the selected cell" do
           part_one
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [8], 1, @binary_matrix.bm)
           puts "\nEnter 8 is north of 3"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 8 is north of 3"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end   

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_one
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [8], @binary_matrix.bmi.mi)
           puts "\nSwap row column 3 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap row column 3 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_one
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([6], [8], 1, @binary_matrix.bm)
           puts "\nEnter 8 is north if 6"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 8 is north of 6"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    
      def part_two
        part_one
        @binary_matrix.bm = @binary_matrix.swap_row_column([2], [4],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [4], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([5], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [1], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [6],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [6], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([3], [8], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [8], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([6], [8], 1, @binary_matrix.bm)
      end

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 6 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 6 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           puts "\nEnter 8 is north of 5"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 8 is north of 5"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 5 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 5 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 into the selected matrix cell" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           puts "\nEnter 1 is north of 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 1 is north of 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

      describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
           puts "\nEnter 9 is north of 3"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 9 is north of 3"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

      describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
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

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [9], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([6], [9], 1, @binary_matrix.bm)
           puts "\nEnter 9 is north of 6"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 9 is north of 6"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [9], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([6], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 6 and 9"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 6 and 9"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end    

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_two
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [9], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([6], [9], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([9], [5], 1, @binary_matrix.bm)
           puts "\nEnter 5 is north of 9"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 5 is north of 9"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      def part_three
        part_two
        @binary_matrix.bm = @binary_matrix.swap_row_column([6], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [8], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([5], [8], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([8], [1], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([3], [9], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [9], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([6], [9], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([9], [5], 1, @binary_matrix.bm)
      end

      describe "#reachability_matrix" do
         it "will calculate reachability_matrix and infer information" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 in the matrix cell" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           puts "\nEnter 11 is north of 10"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 11 in north of 10"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap_row_column that are selected" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           puts "\nSwap swap_row_column 10 and 11"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap swap_row_column 10 and 11"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           puts "\nEnter 12 is north of 3"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 12 is north of 3"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      
      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 3 and 12"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 3 and 12"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  


      describe "#enter_cell_content" do
         it "will enter a 1 into the selected matrix cell" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           puts "\nEnter 11 is north of 2"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 11 is north of 2"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           puts "\nSwap rows columns 2 and 11"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows columns 2 and 11"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 into the selected  matrix cell" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           puts "\nEnter 4 is north of 11"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 4 is north of 11"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 2 and 1"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 2 and 1"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 10 and 11"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 10 and 11"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 5 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 5 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 6 and 5"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 6 and 5"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 9 and 5"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 9 and 5"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_three
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
           @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      def part_four
        part_three
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
        @binary_matrix.enter_cell_content([10], [11], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([3], [12], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([3], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([3], [12], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([2], [11], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([2], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([2], [11], @binary_matrix.bmi.mi)
        @binary_matrix.enter_cell_content([11], [4], 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([1], [2],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [2], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([10], [11],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([10], [11], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([6], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [5], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
        @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
      end

       describe "#enter_cell_content" do
         it "will enter a 1 into the selected matrix cell" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           puts "\nEnter 10 is north of 1"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 10 is north of 1"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 1 and 10"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 1 and 10"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 8 and 1"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 8 and 1"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 5 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 5 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 9 and 5"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 9 and 5"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap the selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 6 and 9"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 6 and 9"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  


      describe "#reachability_matrix" do
         it "will calculate reachability_matrix and infer information" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#enter_cell_content" do
         it "will enter a 1 into the matrix cell" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           puts "\nEnter 12 is north of 1"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 12 is north of 1"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

      describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [12], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 12 and 1"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 12 and 1"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [12], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 1 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 1 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#swap_row_column" do
         it "will swap selected rows and columns" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [12], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           puts "\nSwap rows and columns 1 and 8"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nSwap rows and columns 1 and 8"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  

       describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [12], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end

      end  

       describe "#enter_cell_content" do
         it "will enter a 1 in the selected matrix cell" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [12], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([12], [10], 1, @binary_matrix.bm)
           puts "\nEnter 10 is  north of 12"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nEnter 10 is north of 12"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  


       describe "#reachability_matrix" do
         it "will calculate the reachability_matrix and infer information" do
           part_four
           @binary_matrix.enter_cell_content([1], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [10],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [10], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([9], [5],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([9], [5], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([6], [9],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([6], [9], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([1], [12], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.swap_row_column([1], [12],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([1], [12], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([8], [1],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([8], [1], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.swap_row_column([5], [8],@binary_matrix.bm, @binary_matrix.bmi.mi)
           @binary_matrix.bmi.mi = @binary_matrix.swap_index([5], [8], @binary_matrix.bmi.mi)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           @binary_matrix.enter_cell_content([12], [10], 1, @binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.reachability_matrix(@binary_matrix.bm)
           @binary_matrix.bm = @binary_matrix.subtract_id_matrix(@binary_matrix.bm)
           puts "\nInfer information"
           puts @binary_matrix.bm.to_a.map(&:inspect)
           puts "Matrix Index .. \n"
           p @binary_matrix.bmi.mi.to_a.map(&:inspect)
           logger.info "\nInfer information"
           "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
           logger.info "\n\nMatrix Index"
           logger.info @binary_matrix.bmi.mi.to_a.map(&:inspect)
        end
      end  
















      
end  











