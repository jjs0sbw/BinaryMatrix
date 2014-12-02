require File.expand_path("../../lib/binary_matrix.rb", __FILE__)
require "#{File.dirname(__FILE__)}/spec_helper"
require 'logger'

describe BinaryMatrix do 
  logger = Logger.new('log_one.txt')
  logger.formatter = proc do |severity, datetime, progname, msg|
    "Binary Matrix: #{msg}\n"
  end
  logger.info "\nThis is a info logging file\n"
  before :each do
    @binary_matrix = BinaryMatrix.new(10)
  end
  describe "#new" do
    it "takes one parameter and returns a BinaryMatrix object" do
      expect(@binary_matrix).to be_a_kind_of(BinaryMatrix)
    end

    it "has a size of ten (10)" do
      expect(@binary_matrix.size).to be == 10
    end

    it "has ten (10) rows in the matrix" do
      expect(@binary_matrix.number_of_rows).to be == 10
    end

    it "has ten (10) columns in the matrix" do
      expect(@binary_matrix.number_of_columns).to be == 10
    end

    it "has a two dimensional ten (10) by ten (10) array" do
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
      @binary_matrix.enter_cell_content(2, 5)
      expect(@binary_matrix.add).to be == 1
    end

    it "will enter a zero into the cell if the index numbers are the same" do
      @binary_matrix.enter_cell_content(2, 2)
      expect(@binary_matrix.add).to be == 0
    end

  end  

  describe "#transpose" do
    it "will transpose the matrix contents" do
      temp_matrix = Array.new(5) { Array.new(5, 0) }
      @binary_matrix.enter_cell_content(1, 2)
      @binary_matrix.enter_cell_content(3, 1)
      t_matrix = @binary_matrix.transpose(@binary_matrix.bm)
      expect(@binary_matrix.transpose(@binary_matrix.bm)).to eq t_matrix
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
      temp_matrix_answer = Array.new(11) { Array.new(11, 0) }
      expect(@binary_matrix.expand_end(@binary_matrix.bm)).to eq temp_matrix_answer
    end
  end

  describe "#expand" do
    it "will expand the matrix inserting a row and column at the given index " do
      temp_matrix_answer = Array.new(11) { Array.new(11, 0) }
      expect(@binary_matrix.expand(@binary_matrix.bm, 4)).to eq temp_matrix_answer
    end
  end

  describe "#compress" do
    it "will compress two rows and columns into one" do
      temp_matrix_answer = Array.new(9) { Array.new(9, 0) }
      expect(@binary_matrix.compress(2, 6)).to eq temp_matrix_answer
    end
  end

  describe "#square_print_with_comment" do
    it "will print the matrix in a square format with a commnet" do
      expect { print "test one" }.to output("test one").to_stdout
    end
    it "will print the matrix in a square format with a commnet" do
      expect { @binary_matrix.square_print_with_comment("testOne", \
        @binary_matrix.bm)}.to output("  \ntestOne
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  \n").to_stdout
    end
  end
    describe "#write_log" do
      it "will log the matrix in a square format with a comment to a local file" do
        puts "\n Binary Matrix .. \n"
        puts @binary_matrix.bm.to_a.map(&:inspect)
        puts "Matrix Index .. \n"
        p @binary_matrix.bmi.mi.to_a.map(&:inspect)
        logger.info "\n Enter base binary matrix..\n"
        "#{@binary_matrix.bm.to_a.each{ |r| logger.info r.inspect } }"
        logger.info "\n\nMatrix Index"
        "#{@binary_matrix.bmi.mi.to_a{ logger.info inspect } }"
      end
    end

    describe "#enter_cell_content" do
      it "will add a one to the matrix cell" do
        @binary_matrix.enter_cell_content(1, 2, 1, @binary_matrix.bm)
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
  
    describe "#swap_row_and_column" do
      it "will swap rows and columns to create proper alignment" do
        @binary_matrix.enter_cell_content(1, 2, 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column(@binary_matrix.bm, 1, 2)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index(@binary_matrix.bmi.mi, 1, 2)
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
        @binary_matrix.enter_cell_content(1, 2, 1, @binary_matrix.bm)
        @binary_matrix.bm = @binary_matrix.swap_row_column(@binary_matrix.bm, 1, 2)
        @binary_matrix.bmi.mi = @binary_matrix.swap_index(@binary_matrix.bmi.mi, 1, 2)
        @binary_matrix.enter_cell_content(3, 1, 1, @binary_matrix.bm)
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

      
end  











