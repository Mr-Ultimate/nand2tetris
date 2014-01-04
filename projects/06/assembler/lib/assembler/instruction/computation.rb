# Encoding: utf-8

require 'assembler/instruction/abstract_instruction'

module Assembler
  module Instruction
    class Computation < AbstractInstruction
      attr_reader :destination, :computation, :jump

      # TODO: there really isn't a reason to not just put these in a constructor

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

      def self.new_from_line(instruction)
        if instruction.match(/^(?:([AMD]{0,3})=)?([A-Z01\&\|!\-+]{0,3}\b)(?:;(.{3}))?$/)
          instruction = new
          instruction.destination = $1
          instruction.computation = $2
          instruction.jump = $3
          instruction
        end
      end

      private

      def validate_case(code)
        fail(SyntaxError, "Assembly mnemonics must be written in uppercase, \"#{code}\" is not!") unless code == code.upcase if code
      end

      def encode_destination
        return '000' unless destination
        destination_map.fetch(destination)
        rescue KeyError
          raise SyntaxError, "\"#{destination}\" is not a valid destination code!"
      end

      def destination_map
        {
          'M' => '001', 'D' => '010', 'MD' => '011', 'A' => '100',
          'AM' => '101', 'AD' => '110', 'AMD' => '111'
        }
      end

      def encode_jump
        return '000' unless jump
        jump_map.fetch(jump)
        rescue KeyError
          raise SyntaxError, "\"#{jump}\" is not a valid jump code!"
      end

      def jump_map
        {
          'JGT' => '001', 'JEQ' => '010', 'JGE' => '011', 'JLT' => '100',
          'JNE' => '101', 'JLE' => '110', 'JMP' => '111'
        }
      end

      def encode_computation
        fail SyntaxError, 'A computation code must be provided.' unless computation
        begin
          computation_map.merge(reverse_computation_map).fetch(computation)
        rescue KeyError
          raise SyntaxError, "\"#{computation}\" is not a valid computation code!"
        end
      end

      def computation_map
        {
          '0' => '0101010', '1' => '0111111', '-1' => '0111010', 'D' => '0001100',
          'A' => '0110000', '!D' => '0001101', '!A' => '0110001', '-D' => '0001111',
          '-A' => '0110011', 'D+1' => '0011111', 'A+1' => '0110111', 'D-1' => '0001110',
          'A-1' => '0110010', 'D+A' => '0000010', 'D-A' => '0010011', 'A-D' => '0000111',
          'D&A' => '0000000', 'D|A' => '0010101', 'M' => '1110000', '!M' => '1110001',
          '-M' => '1110011', 'M+1' => '1110111', 'M-1' => '1110010', 'D+M' => '1000010',
          'D-M' => '1010011', 'M-D' => '1000111', 'D&M' => '1000000', 'D|M' => '1010101'
        }
      end

      def reverse_computation_map
        map = {}
        computation_map.each do |code, encoding|
          map[code.reverse] = encoding if code =~ /.[&\|\+]./
        end
        map
      end
    end
  end
end
