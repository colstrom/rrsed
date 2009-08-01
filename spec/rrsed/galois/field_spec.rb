# Copyright (c) 2009 Andrew Kirilenko
# This software is made available under the terms of the MIT License.

$: << "lib"

require "rrsed/galois/field"

module RRSED
  module Galois
    describe Field do
      field = Field.new([1, 0, 0, 0, 1, 1, 1, 0, 1]) # x^8 + x^4 + x^3 + x^2 + 1

      it "should have proper primitive" do
        field.primitive.should == [1, 0, 0, 0, 1, 1, 1, 0, 1]
      end

      it "should have proper power" do
        field.power.should == 8
      end

      it "should have proper size" do
        field.size.should == 255
      end

      it "should accept proper values" do
        field.in_field?(0).should == true
        field.in_field?(13).should == true
        field.in_field?(255).should == true
      end

      it "should not accept inproper values" do
        field.in_field?(-1).should_not == true
        field.in_field?(256).should_not == true
      end

      it "should not accept inproper types" do
        field.in_field?(2.4).should_not == true
        field.in_field?("yo").should_not == true
      end

      it "should do trivial adds properly" do
        field.add(0, 13).should == 13
        field.add(13, 0).should == 13
        field.add(111, 111).should == 0
      end

      it "should do adds properly" do
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

      it "should do trivial subs properly" do
        field.sub(0, 13).should == 13
        field.sub(13, 0).should == 13
        field.sub(111, 111).should == 0
      end

      it "should do subs properly" do
        field.sub(10, 30).should == 20
        field.sub(30, 10).should == 20
        field.sub(111, 222).should == 177
        field.sub(222, 111).should == 177
      end

      it "should raise error on inproper parameter types for sub" do
        lambda { field.sub(2.4, 1) }.should raise_error
        lambda { field.sub(1, "yo") }.should raise_error
      end

      it "should raise error on inproper parameters for sub" do
        lambda { field.sub(-1, 3) }.should raise_error
        lambda { field.sub(3, -1) }.should raise_error
        lambda { field.sub(3, 256) }.should raise_error
        lambda { field.sub(256, 3) }.should raise_error
      end

      it "should do trivial muls properly" do
        field.mul(0, 13).should == 0
        field.mul(13, 0).should == 0
        field.mul(1, 13).should == 13
        field.mul(13, 1).should == 13
      end

      it "should do muls properly" do
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

      it "should do trivial divs properly" do
        field.div(0, 0).should == 0
        field.div(0, 13).should == 0
        field.div(13, 0).should == 0
        field.div(13, 1).should == 13
        field.div(13, 13).should == 1
      end

      it "should do divs properly" do
        field.div(10, 30).should == 244
        field.div(30, 10).should == 3
        field.div(111, 222).should == 142
        field.div(222, 111).should == 2
      end

      it "should raise error on inproper parameter types for div" do
        lambda { field.div(2.4, 1) }.should raise_error
        lambda { field.div(1, "yo") }.should raise_error
      end

      it "should raise error on inproper parameters for div" do
        lambda { field.div(-1, 3) }.should raise_error
        lambda { field.div(3, -1) }.should raise_error
        lambda { field.div(3, 256) }.should raise_error
        lambda { field.div(256, 3) }.should raise_error
      end
    end
  end
end
