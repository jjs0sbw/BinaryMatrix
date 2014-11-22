require_relative '../lib/binary_matrix'
require './spec_helper'

describe BinaryMatrix do 
  
  before :each do
    @binary_matrix = BinaryMatrix.new 10
  end

  describe "#new" do
    it "takes one parameter and returns a BinaryMatrix object" do
      expect(@binary_matrix).to be_a_kind_of(BinaryMatrix)
    end
  end  
end