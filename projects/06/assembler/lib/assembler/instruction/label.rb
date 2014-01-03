# Encoding: utf-8

require 'assembler/instruction/abstract_instruction'

module Assembler
  module Instruction
    class Label < AbstractInstruction
      attr_reader :symbol

      def initialize(symbol)
        @symbol = symbol
      end

      def prepare_line(symbol_table, line_number)
        symbol_table.add_entry(@symbol, line_number)
        line_number
      end
    end
  end
end
