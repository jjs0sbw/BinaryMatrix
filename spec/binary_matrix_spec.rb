require File.expand_path("../../lib/binary_matrix.rb", __FILE__)
require "#{File.dirname(__FILE__)}/spec_helper"

describe BinaryMatrix do 
  before :each do
    @binary_matrix = BinaryMatrix.new 10
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

















end