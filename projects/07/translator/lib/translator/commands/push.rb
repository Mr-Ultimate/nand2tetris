# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Push < Command::Abstract
      def initialize(segment, index, filename = nil)
        @segment, @index = segment, index.to_i
        @lines =  case segment
                  when 'constant'
                    ["@#{@index}"] + %w(D=A) + push
                  when 'local'
                    ["@#{@index}"] + address('LCL') + push
                  when 'argument'
                    ["@#{@index}"] + address('ARG') + push
                  when 'this'
                    ["@#{@index}"] + address('THIS') + push
                  when 'that'
                    ["@#{@index}"] + address('THAT') + push
                  when 'temp'
                    ["@#{@index}"] + %w(D=A @5 A=A+D D=M) + push
                  when 'pointer'
                    ["@#{@index + 3}"] + %w(D=M) + push
                  when 'static'
                    fail ArgumentError, 'Must provide a filename argument for static push.' unless filename
                    ["@#{filename}.#{@index}"] + %w(D=M) + push
                  else
                    fail SyntaxError, "VM Syntax Error: \"#{segment}\" is an unknown segment."
                  end
      end

      private

      def push
        %w(@SP AM=M+1 A=A-1 M=D)
      end

      def address(key)
        ['D=A', "@#{key}", 'A=M+D', 'D=M']
      end
    end
  end
end
