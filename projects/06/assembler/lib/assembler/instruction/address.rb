# Encoding: utf-8

require 'assembler/instruction/abstract_instruction'

module Assembler
  module Instruction
    class Address < AbstractInstruction
      attr_reader :value, :ref

      def initialize(value)
        @value = value =~ /^\d+$/ ? value.to_i : value
      end

      def encode(symbol_table)
        return to_binary(value) if value.is_a?(Numeric)
        if symbol_table.contains? value.to_s
          to_binary symbol_table.address_for(value)
        else
          @ref = symbol_table.add_reference(value)
          to_binary @ref
        end
      end

      private

      def to_binary(numeric)
        sprintf('%016b', numeric)
      end
    end
  end
end
