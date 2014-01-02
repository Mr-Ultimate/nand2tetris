# Encoding: utf-8

module Assembler
  class SourceLine
    attr_reader :raw
    def initialize(source)
      @raw = source
      @source = source.strip.gsub(/\s/, '').sub(%r(//.+), '')
    end

    def blank?
      @source == ''
    end

    def label?
      @source =~ /^\(([A-Z_\:\.\$][A-Z0-9_\:\.\$]*)\)/
    end

    def symbol
      @source.match(/^\(([A-Za-z_\:\.\$][A-Za-z0-9_\:\.\$]*)\)/)[1]
    end

    def variable
      @source.match(/@([a-zA-Z_\:\.\$][a-zA-Z0-9_\:\.\$]*)/)[1]
    end

    def variable?
      @source =~ /@([a-zA-Z_\:\.\$][a-zA-Z0-9_\:\.\$]*)/
    end

    def value
      @source[1..@source.size - 1].to_i if @source[0] == '@'
    end

    def destination
      return_nil_if_empty @source.match(/^(.+?)=/)
    end

    def computation
      return_nil_if_empty @source.match(/^(?:.+=)?(.+?)(?:$|;)/)
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
