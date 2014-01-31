# Encoding: utf-8

require 'translator/job'
require 'translator/runner'
require 'translator/command/factory'

module Translator
  class Cli
    def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      job = Translator::Job.new(@argv.first)
      command_factory = Translator::Command::Factory.new
      @stdout.puts Translator::Runner.new(command_factory).translate(job)
      @kernel.exit(0)
      rescue ArgumentError, SyntaxError => error
        @stderr.puts error.message
        @kernel.exit(1)
    end
  end
end
