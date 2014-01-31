# Encoding: utf-8

require 'spec_helper'
require 'translator/source_line'

describe Translator::SourceLine do

  it 'should be instantiated with the source, line number an file name' do
    line = Translator::SourceLine.new('   push constant 123   //comments', 'filename', 12)
    line.id.should eq 'filename_12'
    line.from_file.should eq 'filename'
    line.instruction.should eq 'push constant 123'
    line.valid?.should be_true
  end

  ['', "\n", "   //some comments \n"].each do |source|
    it "should not be valid if the source is: #{source}" do
      line = Translator::SourceLine.new(source, 'filename', 12)
      line.valid?.should be_false
      line.instruction.should eq ''
    end
  end
end
