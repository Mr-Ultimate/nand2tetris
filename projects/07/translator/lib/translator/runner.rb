# Encoding: utf-8

module Translator
  class Runner
    def translate(job)
# open the output File
# for each input File
  # get command
  # write to file
      # File.write(job.output_path, '')
      "Translated the contents of \"#{job.source_path}\" to \"#{job.output_file.path}\"."
    end
  end
end
