# Encoding: utf-8

module Assembler
  class SymbolTable
    def initialize
      @symbols = {}
      @next_memory = 16
      (0..15).each { |n| add_entry("R#{n}", n) }
      {
        'SP' => 0,
        'LCL' => 1,
        'ARG' => 2,
        'THIS' => 3,
        'THAT' => 4,
        'SCREEN' => 16_384,
        'KBD' => 24_576
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

    def add_reference(symbol)
      last_memory = @next_memory
      add_entry(symbol, last_memory)
      @next_memory += 1
      last_memory
    end
  end
end
