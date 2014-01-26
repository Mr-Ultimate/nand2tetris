# Encoding: utf-8

require 'spec_helper'
require 'translator/job'

describe Translator::Job do

  before(:each) do
    @tmp_dir = File.join(Dir.pwd, 'build', 'tmp', 'spec')
    FileUtils.mkdir_p(@tmp_dir)
  end

  it 'should raise an error if no path is provided' do
    expect_argument_error('You must provide a file or directory to translate.') do
      Translator::Job.new(nil)
    end
  end

  it 'should raise an error if the path does not exist' do
    expect_argument_error('Error: "not_exist" was not found.') do
      Translator::Job.new('not_exist')
    end
    expect_argument_error('Error: "not_exist.txt" was not found.') do
      Translator::Job.new('not_exist.txt')
    end
  end

  it 'should raise an error if the path does not contain any files with the .vm extension' do
    dir = create_dir('source')
    create_file('source/file.txt')
    expect_argument_error("Error: The directory \"#{dir}\" does not contain any *.vm files.") do
      Translator::Job.new(dir)
    end
  end

  it 'should raise an error if the file provide does not have a *.vm extension' do
    source_path = create_file('source.txt')
    expect_argument_error("Error: The file \"#{source_path}\" must have a .vm extension.") do
      Translator::Job.new(source_path)
    end
  end

  it 'should determine the output file from an input file' do
    source_path = create_file('source.vm')
    job = Translator::Job.new(source_path)
    job.source_path.should eq source_path
    job.output_path.should eq File.join(@tmp_dir, 'source.asm')
  end

  it 'should determine the output file from an input directory' do
    source_path = create_dir('source')
    create_file('source/file.vm')
    job = Translator::Job.new(source_path)
    job.source_path.should eq source_path
    job.output_path.should eq File.join(@tmp_dir, 'source.asm')
  end

  it 'should indicate if there are source files remaining in the job' do
    source_path = create_file('file.vm')
    job = Translator::Job.new(source_path)
    job.source_files_remaining?.should be_true
    job.next_source_file
    job.source_files_remaining?.should be_false
    job.file_name.should eq 'file'
    job.file_path.should eq source_path
  end

  it 'should load the next source file from a directory' do
    source_path = create_dir('source')
    create_file('source/file1.vm')
    create_file('source/file2.vm')
    job = Translator::Job.new(source_path)
    job.next_source_file.file_name.should eq 'file1'
    job.next_source_file.file_name.should eq 'file2'
  end

  it 'should raise an error if there are no more source files' do
    expect do
      source_path = create_file('file.vm')
      job = Translator::Job.new(source_path)
      job.next_source_file.next_source_file
    end.to raise_error 'There are no more source files in the job.'
  end

  after(:each) do
    FileUtils.rm_rf(@tmp_dir)
  end
end

def create_file(path)
  file = File.join(@tmp_dir, path)
  FileUtils.touch(file)
  file
end

def create_dir(path)
  dir = File.join(@tmp_dir, path)
  FileUtils.mkdir_p(dir)
  dir
end

def expect_argument_error(message)
  expect do
    yield
  end.to raise_error ArgumentError, message
end
