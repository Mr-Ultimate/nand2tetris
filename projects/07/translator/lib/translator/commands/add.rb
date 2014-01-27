# Encoding: utf-8

module Translator
  module Commands
    class Add
      def translate(output_file)
        %w(@SP AM=M-1 D=M M=0 A=A-1 M=D+M).each do |instruction|
          output_file.write("#{instruction}\n")
        end
      end
    end
  end
end
