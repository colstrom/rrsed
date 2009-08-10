# Copyright (c) 2009 Andrew Kirilenko
# This software is made available under the terms of the MIT License.

require "rrsed/galois/field"

module RRSED
  module Galois
    class Element
      attr_reader :field
      attr_reader :value

      def initialize(field, value)
        raise unless field.kind_of? Field
        raise unless field.in_field? value

        @field = field
        @value = value
      end

      public
      def ==(o)
        return false unless o.kind_of? Element

        @field == o.field && @value == o.value
      end

      public
      def +(o)
        raise unless o.kind_of? Element
        raise unless @field == o.field

        Element.new(@field, @field.add(@value, o.value))
      end

      public
      def -(o)
        raise unless o.kind_of? Element
        raise unless @field == o.field

        Element.new(@field, @field.sub(@value, o.value))
      end

      public
      def *(o)
        raise unless o.kind_of? Element
        raise unless @field == o.field

        Element.new(@field, @field.mul(@value, o.value))
      end

      public
      def /(o)
        raise unless o.kind_of? Element
        raise unless @field == o.field

        Element.new(@field, @field.div(@value, o.value))
      end
    end
  end
end
