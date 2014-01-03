# Encoding: utf-8

require 'assembler/source_line'
require 'assembler/source_line_encoder'
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

      # # Loop 1
      # line_number = 0
      # File.open(source_file, 'r').each do |source_line|
      #   parsed_line = Assembler::SourceLine.new(source_line)
      #   if parsed_line.label?
      #     symbol_table.add_entry(parsed_line.symbol, line_number)
      #   end
      #   unless parsed_line.blank? || parsed_line.label?
      #     line_number += 1
      #   end
      # end


      File.open(dest_file, 'w') do |output|
        File.open(source_file, 'r').each do |line|
          instruction = Assembler::Instruction::Factory.build_instruction(line)
          if instruction
            encoded = instruction.encode(symbol_table)
            output.puts encoded if encoded
          end
        end
      end



      # Loop 2

      # File.open(dest_file, 'w') do |output|
      #   File.open(source_file, 'r').each do |source_line|
      #     parsed_line = Assembler::SourceLine.new(source_line)
      #     unless parsed_line.blank? || parsed_line.label?

      #       if parsed_line.variable?
      #         if symbol_table.contains?(parsed_line.variable)
      #           value = symbol_table.address_for(parsed_line.variable)
      #           new_line = Assembler::SourceLine.new("@#{value}")
      #           encoded = Assembler::SourceLineEncoder.new(new_line).encode
      #         else
      #           symbol_table.add_reference(parsed_line.variable)
      #           value = symbol_table.address_for(parsed_line.variable)
      #           new_line = Assembler::SourceLine.new("@#{value}")
      #           encoded = Assembler::SourceLineEncoder.new(new_line).encode
      #         end
      #       else
      #         encoded = Assembler::SourceLineEncoder.new(parsed_line).encode
      #       end
      #       output.puts encoded
      #     end
      #   end
      # end
    end
  end
end
