# Encoding: utf-8

module Translator
  class Job
    VM_EXTENSION = '.vm'
    ASM_EXTENSION = '.asm'

    attr_reader :output_path, :source_path, :file_name, :file_path

    def initialize(source_path)
      fail ArgumentError, 'You must provide a file or directory to translate.' unless source_path
      fail ArgumentError, "Error: \"#{source_path}\" was not found." unless File.exist?(source_path)
      if File.directory?(source_path)
        files = Dir.glob(File.join(source_path, "*#{VM_EXTENSION}"))
        fail ArgumentError, "Error: The directory \"#{source_path}\" does not contain any *.vm files." if files.empty?
        output_path = source_path + ASM_EXTENSION
      else
        fail ArgumentError, "Error: The file \"#{source_path}\" must have a .vm extension." unless File.extname(source_path) == VM_EXTENSION
        output_path = source_path.gsub(/#{VM_EXTENSION}$/, ASM_EXTENSION)
        files = [source_path]
      end
      @source_path = source_path
      @output_path = output_path
      @files = files
      @total_source_files = files.count
      @source_file_pointer = -1
    end

    def source_files_remaining?
      @source_file_pointer + 1 < @total_source_files
    end

    def next_source_file
      fail 'There are no more source files in the job.' unless source_files_remaining?
      @source_file_pointer += 1
      file = @files[@source_file_pointer]
      @file_path = file
      @file_name = File.basename(file, VM_EXTENSION)
      self
    end
  end
end
