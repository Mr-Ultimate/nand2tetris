# Encoding: utf-8

module Translator
  class Runner
    def translate(job)
      File.write(job.output_path, '')
      "Translated the contents of \"#{job.source_path}\" to \"#{job.output_path}\"."
    end
  end
end
