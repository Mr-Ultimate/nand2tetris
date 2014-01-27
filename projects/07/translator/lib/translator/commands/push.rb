# Encoding: utf-8

module Translator
  module Commands
    class Push
      def initialize(segment, index)
        @segment, @index = segment, index
      end

      def translate(output_file)
        output_file.write("@#{@index}\n")
        output_file.write("D=A\n")
        output_file.write("@SP\n")
        output_file.write("AM=M+1\n")
        output_file.write("A=A-1\n")
        output_file.write("M=D\n")
      end
    end
  end
end
