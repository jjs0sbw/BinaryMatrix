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

  end  


end