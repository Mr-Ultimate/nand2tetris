# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Push < Command::Abstract
      def initialize(segment, index)
        @segment, @index = segment, index
        @lines =  case segment
                  when 'constant'
                    ["@#{index}"] + %w(D=A @SP AM=M+1 A=A-1 M=D)
                  when 'local'
                    ["@#{index}"] + %w(D=A @LCL A=M+D D=M @SP AM=M+1 A=A-1 M=D)
                  when 'argument'
                    ["@#{index}"] + %w(D=A @ARG A=M+D D=M @SP AM=M+1 A=A-1 M=D)
                  when 'this'
                    ["@#{index}"] + %w(D=A @THIS A=M+D D=M @SP AM=M+1 A=A-1 M=D)
                  when 'that'
                    ["@#{index}"] + %w(D=A @THAT A=M+D D=M @SP AM=M+1 A=A-1 M=D)
                  when 'temp'
                    ["@#{index}"] + %w(D=A @5 A=A+D D=M @SP AM=M+1 A=A-1 M=D)
                  else
                    fail SyntaxError, "VM Syntax Error: \"#{segment}\" is an unknown segment."
        end
      end
    end
  end
end
