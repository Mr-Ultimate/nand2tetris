# Encoding: utf-8

require 'assembler/encoder/integer'
require 'assembler/encoder/computation'
require 'assembler/encoder/destination'
require 'assembler/encoder/jump'

module Assembler
  class SourceLineEncoder
    def initialize(source_line)
      @source_line = source_line
    end

    def encode
      if @source_line.value
        Encoder::Integer.new(@source_line.value).encode
      else
        computation = Encoder::Computation.new(@source_line.computation).encode
        destination = Encoder::Destination.new(@source_line.destination).encode
        jump = Encoder::Jump.new(@source_line.jump).encode
        '111' + computation + destination + jump
      end
    end
  end
end
