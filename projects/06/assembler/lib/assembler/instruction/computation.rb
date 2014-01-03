# Encoding: utf-8

require 'assembler/instruction/abstract_instruction'

module Assembler
  module Instruction
    class Computation < AbstractInstruction
      attr_reader :destination, :computation, :jump

      def jump=(jump)
        validate_case jump
        @jump = jump
      end

      def destination=(destination)
        validate_case destination
        @destination = destination
      end

      def computation=(computation)
        validate_case computation
        @computation = computation
      end

      def encode(symbol_table)
        '111' + encode_computation + encode_destination + encode_jump
      end

      private

      def validate_case(code)
        fail(SyntaxError, "Assembly mnemonics must be written in uppercase, \"#{code}\" is not!") unless code == code.upcase
      end

      def encode_destination
        return '000' unless destination
        {
          'M' => '001',
          'D' => '010',
          'MD' => '011',
          'A' => '100',
          'AM' => '101',
          'AD' => '110',
          'AMD' => '111'
        }.fetch(destination)
      end

      def encode_computation
        fail SyntaxError, 'A computation code must be provided.' unless computation
        # begin
          {
            '0' => '0101010',
            '1' => '0111111',
            '-1' => '0111010',
            'D' => '0001100',
            'A' => '0110000',
            '!D' => '0001101',
            '!A' => '0110001',
            '-D' => '0001111',
            '-A' => '0110011',
            'D+1' => '0011111',
            'A+1' => '0110111',
            'D-1' => '0001110',
            'A-1' => '0110010',
            'D+A' => '0000010',
            'D-A' => '0010011',
            'A-D' => '0000111',
            'D&A' => '0000000',
            'D|A' => '0010101',
            'M' => '1110000',
            '!M' => '1110001',
            '-M' => '1110011',
            'M+1' => '1110111',
            'M-1' => '1110010',
            'D+M' => '1000010',
            'D-M' => '1010011',
            'M-D' => '1000111',
            'D&M' => '1000000',
            'D|M' => '1010101'
          }.fetch(computation)
        # rescue KeyError
          # raise SyntaxError, "#{self.inspect}"
        # end
      end

      def encode_jump
        return '000' unless jump
        {
          'JGT' => '001',
          'JEQ' => '010',
          'JGE' => '011',
          'JLT' => '100',
          'JNE' => '101',
          'JLE' => '110',
          'JMP' => '111'
        }.fetch(jump)
      end
    end
  end
end
