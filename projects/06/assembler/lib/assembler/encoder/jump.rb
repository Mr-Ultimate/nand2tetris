# Encoding: utf-8

module Assembler
  module Encoder
    class Jump
      attr_reader :code

      def initialize(code)
        @code = code
      end

      def encode
        return '000' if @code.nil?
        fail(SyntaxError, "Assembly mnemonics must be written in uppercase, \"#{@code}\" is not!") unless @code == @code.upcase
        code_map.fetch(@code.downcase.to_sym)
        rescue KeyError
          raise SyntaxError, "\"#{@code}\" is not a valid jump code!"
      end

      private

      def code_map
        {
          jgt: '001',
          jeq: '010',
          jge: '011',
          jlt: '100',
          jne: '101',
          jle: '110',
          jmp: '111'
        }
      end
    end
  end
end
