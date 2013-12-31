# Encoding: utf-8

require 'assembler/source_line'
require 'assembler/source_line_encoder'

module Assembler
  class Application
    def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      source_file = @argv.first
      puts source_file
      dest_file = @argv.first.match(/(.+)\.asm/)[1] + '.hack'

      File.open(dest_file, 'w') do |output|
        File.open(source_file, 'r').each do |source_line|
          parsed_line = Assembler::SourceLine.new(source_line)
          unless parsed_line.blank?
            encoded = Assembler::SourceLineEncoder.new(parsed_line).encode
            output.puts encoded
          end
        end
      end
    end
  end
end
