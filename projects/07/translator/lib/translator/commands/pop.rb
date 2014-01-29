# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Pop < Command::Abstract
      def initialize(segment, index)
        @segment, @index = segment, index
        @lines =  case segment
                  when 'local'
                    ["@#{index}"] + %w(D=A @LCL D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
                  when 'argument'
                    ["@#{index}"] + %w(D=A @ARG D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
                  when 'this'
                    ["@#{index}"] + %w(D=A @THIS D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
                  when 'that'
                    ["@#{index}"] + %w(D=A @THAT D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
                  when 'temp'
                    ["@#{index}"] + %w(D=A @5 D=A+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
                  else
                    fail SyntaxError, "VM Syntax Error: \"#{segment}\" is an unknown segment."
        end
      end
    end
  end
end
