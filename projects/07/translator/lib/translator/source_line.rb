# Encoding: utf-8

module Translator
  class SourceLine
    attr_reader :id, :from_file, :instruction
    def initialize(source, file, line_number)
      @id = file + '_' + line_number.to_s
      @from_file = file
      @instruction = source.gsub(%r(//.+), '').strip
    end

    def valid?
      ! @instruction.empty?
    end
  end
end
