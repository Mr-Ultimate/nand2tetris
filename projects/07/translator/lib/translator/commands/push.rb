# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Push < Command::Abstract
      def initialize(segment, index)
        @segment, @index = segment, index
        @lines = ["@#{index}"] + %w( D=A @SP AM=M+1 A=A-1 M=D)
      end
    end
  end
end
