# Encoding: utf-8

require 'translator/source_line'

module Translator
  class Runner
    def initialize(command_factory)
      @command_factory = command_factory
    end

    def translate(job)
      while job.source_files_remaining?
        job.next_source_file
        line_number = 0
        job.file.each do |line|
          line = Translator::SourceLine.new(line, job.file_name, line_number)
          @command_factory.build(line).translate(job.output_file) if line.valid?
          line_number += 1
        end
      end
      job.output_file.close
      "Translated the contents of \"#{job.source_path}\" to \"#{job.output_file.path}\"."
    end
  end
end
