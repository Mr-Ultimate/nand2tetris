# Encoding: utf-8

require 'translator/command/abstract'

module Translator
  module Commands
    class Negate < Command::Abstract
      def initialize
        @lines = %w(@SP A=M-1 M=-M)
      end
    end
  end
end
