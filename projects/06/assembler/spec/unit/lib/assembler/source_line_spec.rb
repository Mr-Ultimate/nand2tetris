# Encoding: utf-8

require 'spec_helper'
require 'assembler/source_line'

describe Assembler::SourceLine do
  it 'should be initialized with a string' do
    source = '   @123  //comment'
    Assembler::SourceLine.new(source).raw.should eq source
  end

  it 'should return the decimal for an A instruction' do
    line = Assembler::SourceLine.new('@123')
    line.symbol.should eq 123
  end

  it 'should strip white space and trailing comments' do
    line = Assembler::SourceLine.new('     @123  //comment')
    line.symbol.should eq 123
  end

  it 'should return a destination code' do
    line = Assembler::SourceLine.new('D = A')
    line.destination.should eq 'D'
  end

  it 'should return a computation code' do
    line = Assembler::SourceLine.new('D = A')
    line.computation.should eq 'A'
  end

  it 'should return a jump code' do
    line = Assembler::SourceLine.new('D;JEQ')
    line.jump.should eq 'JEQ'
  end

  it 'should parse a complex code' do
    line = Assembler::SourceLine.new('AM = D+A ;JEQ')
    line.destination.should eq 'AM'
    line.computation.should eq 'D+A'
    line.jump.should eq 'JEQ'
  end
end
