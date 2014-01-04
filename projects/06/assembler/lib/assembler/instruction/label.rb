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

      def self.new_from_line(instruction)
        parts = /^\(([A-Za-z_\:\.\$][A-Za-z0-9_\:\.\$]*)\)/.match(instruction)
        new(parts[1]) unless parts.nil?
      end
    end
  end
end
