# Copyright (c) 2009 Andrew Kirilenko
# This software is made available under the terms of the MIT License.

module RRSED
  module Galois
    class Field
      attr_reader :primitive
      attr_reader :power
      attr_reader :size

      def initialize(primitive)
        @primitive = primitive
        @power = primitive.size - 1
        @size = (1 << @power) - 1

        generate_exp
        generate_log
      end

      public
      def in_field?(x)
        return false unless x.kind_of? Fixnum
        return false if x < 0 || x > @size

        true
      end

      public
      def add(x, y)
        raise unless in_field?(x)
        raise unless in_field?(y)

        x ^ y
      end

      public
      def sub(x, y)
        add(x, y)
      end

      public
      def mul(x, y)
        raise unless in_field?(x)
        raise unless in_field?(y)

        return 0 if x == 0 || y == 0
        return x if y == 1
        return y if x == 1

        @exp[(@log[x] + @log[y]) % @size]
      end

      public
      def div(x, y)
        raise unless in_field?(x)
        raise unless in_field?(y)

        return 0 if x == 0 || y == 0

        @exp[(@log[x] - @log[y] + @size) % @size]
      end

      private
      def generate_exp
        @exp = []

        mask = 1
        primitive_value = 0
        (0 .. @power - 1).each do |i|
          @exp << mask
          primitive_value = primitive_value | mask if @primitive[i] == 1
          mask = mask << 1
        end

        @exp << primitive_value

        mask = mask >> 1
        (@power + 1 .. @size - 1).each do |i|
          if @exp[-1] >= mask
            @exp << (primitive_value ^ ((@exp[-1] ^ mask) << 1))
          else
            @exp << (@exp[-1] << 1)
          end
        end

        @exp << 1
      end

      private
      def generate_log
        @log = [nil]

        (1 .. @size).each do |i|
          @log << @exp.index(i)
        end
      end
    end
  end
end
