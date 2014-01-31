# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Or < Command::Abstract
      def initialize
        @lines = %w(@SP AM=M-1 D=M A=A-1 M=M|D)
      end
    end
  end
end
