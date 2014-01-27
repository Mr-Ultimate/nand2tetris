# Encoding: utf-8

module Translator
  class Runner
    def initialize(command_factory)
      @command_factory = command_factory
    end

    def translate(job)
      while job.source_files_remaining?
        job.next_source_file
        job.file.each do |line|
          command = @command_factory.build(line)
          command.translate(job.output_file) if command
        end
      end
      job.output_file.close
      "Translated the contents of \"#{job.source_path}\" to \"#{job.output_file.path}\"."
    end
  end
end
