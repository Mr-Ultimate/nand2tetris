# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Add < Command::Abstract
      def initialize
        @lines =  %w(@SP AM=M-1 D=M M=0 A=A-1 M=D+M)
      end
    end
  end
end
