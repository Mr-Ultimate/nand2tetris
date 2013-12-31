# Encoding: utf-8

module Assembler
  module Encoder
    class Integer
      def initialize(integer)
        @integer = integer
      end

      def encode
        sprintf('%016b', @integer)
      end
    end
  end
end
