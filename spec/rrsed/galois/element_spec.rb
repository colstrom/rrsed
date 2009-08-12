# Copyright (c) 2009 Andrew Kirilenko
# This software is made available under the terms of the MIT License.

$: << "lib"

require "rrsed/galois/element"

module RRSED
  module Galois
    describe Element do
      field = Field.new([1, 0, 1, 1, 1, 0, 0, 0, 1]) # x^8 + x^4 + x^3 + x^2 + 1
      another_field = Field.new([1, 1, 1, 0, 0, 0, 0, 1, 1]) # x^8 + x^7 + x^2 + x + 1
      x = Element.new(field, 10)
      y = Element.new(field, 30)
      another_element = Element.new(another_field, 10)

      it "should properly test for equality" do
        (x == Element.new(field, 10)).should == true
        (x == y).should == false
        (x == another_element).should == false
        (x == "yo").should == false
      end

      it "should have proper field" do
        x.field.should == field
        y.field.should == field
      end

      it "should have proper value" do
        x.value.should == 10
        y.value.should == 30
      end

      it "should raise error when constructed with improper field type" do
        lambda { Element.new("yo", 1) }.should raise_error
      end

      it "should raise error when constructed with improper value type" do
        lambda { Element.new(field, "yo") }.should raise_error
      end

      it "should raise error when constructed with improper value" do
        lambda { Element.new(field, -1) }.should raise_error
        lambda { Element.new(field, 256) }.should raise_error
      end

      it "should do adds properly" do
        (x + y).field.should == field
        (x + y).value.should == 20
      end

      it "should raise error on inproper rvalue type for add" do
        lambda { x + 30 }.should raise_error
      end

      it "should raise error on different rvalue field for add" do
        lambda { x + another_element }.should raise_error
      end

      it "should do subs properly" do
        (x - y).field.should == field
        (x - y).value.should == 20
      end

      it "should raise error on inproper rvalue type for sub" do
        lambda { x - 30 }.should raise_error
      end

      it "should raise error on different rvalue field for sub" do
        lambda { x - another_element }.should raise_error
      end

      it "should do muls properly" do
        (x * y).field.should == field
        (x * y).value.should == 204
      end

      it "should raise error on inproper rvalue type for mul" do
        lambda { x * 30 }.should raise_error
      end

      it "should raise error on different rvalue field for mul" do
        lambda { x * another_element }.should raise_error
      end

      it "should do divs properly" do
        (x / y).field.should == field
        (x / y).value.should == 244
      end

      it "should raise error on inproper rvalue type for div" do
        lambda { x / 30 }.should raise_error
      end

      it "should raise error on different rvalue field for div" do
        lambda { x / another_element }.should raise_error
      end
    end
  end
end
