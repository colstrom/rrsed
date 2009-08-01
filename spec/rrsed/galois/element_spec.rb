# Copyright (c) 2009 Andrew Kirilenko
# This software is made available under the terms of the MIT License.

$: << "lib"

require "rrsed/galois/element"

module RRSED
  module Galois
    describe Element do
      field = Field.new([1, 0, 1, 1, 1, 0, 0, 0, 1]) # x^8 + x^4 + x^3 + x^2 + 1
      x = Element.new(field, 10)
      y = Element.new(field, 30)

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
        (x + y).value.should == 20
      end

      it "should raise error on inproper rvalue type for add" do
        lambda { x + 30 }.should raise_error
      end

      it "should do subs properly" do
        (x - y).value.should == 20
      end

      it "should raise error on inproper rvalue type for sub" do
        lambda { x - 30 }.should raise_error
      end

      it "should do muls properly" do
        (x * y).value.should == 204
      end

      it "should raise error on inproper rvalue type for mul" do
        lambda { x * 30 }.should raise_error
      end

      it "should do divs properly" do
        (x / y).value.should == 244
      end

      it "should raise error on inproper rvalue type for div" do
        lambda { x / 30 }.should raise_error
      end
    end
  end
end
