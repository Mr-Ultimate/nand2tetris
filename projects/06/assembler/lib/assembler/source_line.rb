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
      @source.split('=').first
    end

    def computation
      @source.split('=').last.split(';').first
    end

    def jump
      @source.split(';').last
    end
  end
end
