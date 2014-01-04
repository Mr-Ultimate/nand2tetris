# Encoding: utf-8

require 'assembler/symbol_table'
require 'assembler/instruction/factory'

module Assembler
  class Application
    def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      source_file = @argv.first
      puts source_file
      dest_file = @argv.first.match(/(.+)\.asm/)[1] + '.hack'

      symbol_table = Assembler::SymbolTable.new

      line_number = 0
      File.open(source_file, 'r').each do |line|
        instruction = Assembler::Instruction::Factory.build_instruction(line)
        if instruction
          line_number = instruction.prepare_line(symbol_table, line_number)
        end
      end

      File.open(dest_file, 'w') do |output|
        File.open(source_file, 'r').each do |line|
          instruction = Assembler::Instruction::Factory.build_instruction(line)
          if instruction
            encoded = instruction.encode(symbol_table)
            output.puts encoded if encoded
          end
        end
      end
    end
  end
end
