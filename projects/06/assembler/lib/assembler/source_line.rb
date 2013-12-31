# Encoding: utf-8

module Assembler
  class SourceLine
    attr_reader :raw
    def initialize(source)
      @raw = source
      @source = source.strip.gsub(/\s/, '').sub(%r(//.+), '')
    end

    def symbol
      @source[1..@source.size - 1].to_i if @source[0] == '@'
    end

    def destination
      return_nil_if_empty @source.match(/^(.+?)[=;]/)
    end

    def computation
      return_nil_if_empty @source.match(/=(.+?)(?:;|$)/)
    end

    def jump
      return_nil_if_empty @source.match(/;(.+)$/)
    end

    private

    def return_nil_if_empty(matches)
      matches.to_a.empty? ? nil : matches[1]
    end
  end
end
