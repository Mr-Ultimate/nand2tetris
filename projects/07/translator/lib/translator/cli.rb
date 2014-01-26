# Encoding: utf-8

module Translator
  class Cli
  end
end

# Encoding: utf-8

module Translator
  class Cli
    def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      fail ArgumentError, 'You must provide a file or directory to translate.' if @argv.empty?
      argument = @argv.first
      unless File.exist?(argument)
        fail ArgumentError, "The file: \"not_exist.txt\" was not found."
      end
      rescue ArgumentError => error
        @stderr.puts error.message
        @kernel.exit(1)

      # source_file = @argv.first
      # puts source_file
      # dest_file = @argv.first.match(/(.+)\.asm/)[1] + '.hack'
    end
  end
end
