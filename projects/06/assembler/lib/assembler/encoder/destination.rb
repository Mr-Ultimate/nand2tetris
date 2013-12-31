# Encoding: utf-8

module Assembler
  module Encoder
    class Destination
      attr_reader :code

      def initialize(code)
        @code = code
      end

      def encode
        return '000' if @code.nil?
        fail(SyntaxError, "Assembly mnemonics must be written in uppercase, \"#{@code}\" is not!") unless @code == @code.upcase
        code_map.fetch(@code.downcase.to_sym)
        rescue KeyError
          raise SyntaxError, "\"#{@code}\" is not a valid destination code!"
      end

      private

      def code_map
        {
          m: '001',
          d: '010',
          md: '011',
          a: '100',
          am: '101',
          ad: '110',
          amd: '111'
        }
      end
    end
  end
end
