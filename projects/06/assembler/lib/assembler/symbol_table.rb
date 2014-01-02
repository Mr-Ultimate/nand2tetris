# Encoding: utf-8

module Assembler
  class SymbolTable
    def initialize
      @symbols = {}
      (0..15).each { |n| add_entry("R#{n}", n) }
      {
        'SP' => 0,
        'LCL' => 1,
        'ARG' => 2,
        'THIS' => 3,
        'THAT' => 4,
        'SCREEN' => 16384,
        'KBD' => 24576
      }.each { |symbol, address| add_entry(symbol, address) }
    end

    def add_entry(symbol, address)
      @symbols[symbol] = address
    end

    def contains?(symbol)
      @symbols.keys.include?(symbol)
    end

    def address_for(symbol)
      address = @symbols.fetch(symbol, nil)
      fail ArgumentError, "The symbol, \"#{symbol}\", can not be found!" unless address
      address
    end
  end
end
