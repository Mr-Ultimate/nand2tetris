# Encoding: utf-8

module Translator
  module Command
    class Abstract
      def translate(output_file)
        @lines.each do |line|
          output_file.write("#{line}\n")
        end
      end
    end
  end
end
