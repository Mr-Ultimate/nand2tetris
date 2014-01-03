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
        label = line.match(/^\(([A-Za-z_\:\.\$][A-Za-z0-9_\:\.\$]*)\)/)
        return Label.new(label[1]) if label
        address = line.match(/^@(\d+$|[a-zA-Z_\$\:][a-zA-Z0-9_\$\:]+)/)
        return Address.new(address[1]) if address
        computation = line.match(/^(?:([AMD]{0,3})=)?([\w\&\|!\-+]{0,3})(?:;(.{3}))?/)
        if computation
          c = Computation.new
          c.destination = $1 if $1
          c.computation = $2 if $2
          c.jump = $3 if $3
          c
        end
      end
    end
  end
end
