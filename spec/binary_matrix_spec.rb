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









end