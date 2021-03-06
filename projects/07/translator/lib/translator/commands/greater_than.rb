# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class GreaterThan < Command::Abstract
      def initialize(id)
        @lines = %w(@SP AM=M-1 D=M A=A-1 D=M-D M=0) + ["@END_GT_#{id}"] + %w(D;JLE @SP A=M-1 M=-1) + ["(END_GT_#{id})"]
      end
    end
  end
end
