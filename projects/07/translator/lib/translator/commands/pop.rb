# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Pop < Command::Abstract
      def initialize(segment, index, filename = nil)
        @segment, @index = segment, index.to_i
        @lines =  case segment
                  when 'local'
                    ["@#{@index}"] + address('LCL') + pop
                  when 'argument'
                    ["@#{@index}"] + address('ARG') + pop
                  when 'this'
                    ["@#{@index}"] + address('THIS') + pop
                  when 'that'
                    ["@#{@index}"] + address('THAT') + pop
                  when 'temp'
                    ["@#{@index}"] + %w(D=A @5 D=A+D) + pop
                  when 'pointer'
                    %w(@SP AM=M-1 D=M) + ["@#{@index + 3}"] + %w(M=D)
                  when 'static'
                    fail ArgumentError, 'Must provide a filename argument for static pop.' unless filename
                    %w(@SP AM=M-1 D=M) + ["@#{filename}.#{@index}"] + %w(M=D)
                  else
                    fail SyntaxError, "VM Syntax Error: \"#{segment}\" is an unknown segment."
                  end
      end

      private

      def pop
        %w(@R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
      end

      def address(key)
        ['D=A', "@#{key}", 'D=M+D']
      end
    end
  end
end
