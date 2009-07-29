# Copyright (c) 2009 Andrew Kirilenko
# This software is made available under the terms of the MIT License.

$: << "lib"

require "galois/field"

module RRSED
  module Galois
    describe Field do
      field = Field.new([1, 0, 0, 0, 1, 1, 1, 0, 1]) # x^8 + x^4 + x^3 + x^2 + 1

      it "it should have proper power" do
        field.power.should == 8
      end

      it "it should have proper size" do
        field.size.should == 256
      end

      it "it should do trivial adds properly" do
        field.add(0, 13).should == 13
        field.add(13, 0).should == 13
        field.add(111, 111).should == 0
      end

      it "it should do adds properly" do
        field.add(10, 30).should == 20
        field.add(30, 10).should == 20
        field.add(111, 222).should == 177
        field.add(222, 111).should == 177
      end

      it "should raise error on inproper parameter types for add" do
        lambda { field.add(2.4, 1) }.should raise_error
        lambda { field.add(1, "yo") }.should raise_error
      end

      it "should raise error on inproper parameters for add" do
        lambda { field.add(-1, 3) }.should raise_error
        lambda { field.add(3, -1) }.should raise_error
        lambda { field.add(3, 256) }.should raise_error
        lambda { field.add(256, 3) }.should raise_error
      end

      it "it should do trivial muls properly" do
        field.mul(0, 13).should == 0
        field.mul(13, 0).should == 0
        field.mul(1, 13).should == 13
        field.mul(13, 1).should == 13
      end

      it "it should do muls properly" do
        field.mul(10, 30).should == 204
        field.mul(30, 10).should == 204
        field.mul(111, 222).should == 197
        field.mul(222, 111).should == 197
      end

      it "should raise error on inproper parameter types for mul" do
        lambda { field.mul(2.4, 1) }.should raise_error
        lambda { field.mul(1, "yo") }.should raise_error
      end

      it "should raise error on inproper parameters for mul" do
        lambda { field.mul(-1, 3) }.should raise_error
        lambda { field.mul(3, -1) }.should raise_error
        lambda { field.mul(3, 256) }.should raise_error
        lambda { field.mul(256, 3) }.should raise_error
      end
    end
  end
end
