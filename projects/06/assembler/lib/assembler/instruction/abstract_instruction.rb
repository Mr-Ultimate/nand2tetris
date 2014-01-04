# Encoding: utf-8

module Assembler
  module Instruction
    class AbstractInstruction
      def prepare_line(symbol_table, line_number)
        line_number + 1
      end

      def encode(symbol_table)
        nil
      end

      # TODO: the static parsing could be pulled up here and delegated to a pattern
    end
  end
end
