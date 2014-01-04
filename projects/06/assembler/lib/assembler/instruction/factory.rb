# Encoding: utf-8

require 'assembler/instruction/label'
require 'assembler/instruction/address'
require 'assembler/instruction/computation'

module Assembler
  module Instruction
    class Factory
      def self.build_instruction(line)
        cleaned = clean(line)
        return nil if cleaned == ''
        parse_to_instruction(cleaned)
      end

      private

      def self.clean(line)
        line.strip.gsub(/\s/, '').gsub(%r(//.+), '')
      end

      def self.parse_to_instruction(line)
        Label.new_from_line(line) ||
        Address.new_from_line(line) ||
        Computation.new_from_line(line)
      end
    end
  end
end
