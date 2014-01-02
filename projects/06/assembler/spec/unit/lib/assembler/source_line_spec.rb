# Encoding: utf-8

require 'spec_helper'
require 'assembler/source_line'

describe Assembler::SourceLine do
  it 'should report if the line is blank' do
    source = '     //comment'
    Assembler::SourceLine.new(source).blank?.should be_true
  end

  it 'should be initialized with a string' do
    source = '   @123  //comment'
    Assembler::SourceLine.new(source).raw.should eq source
  end

  it 'should return the decimal for an A instruction' do
    line = Assembler::SourceLine.new('@123')
    line.value.should eq 123
    line.variable?.should be_false
  end

  it 'should return the variable for an A instruction' do
    line = Assembler::SourceLine.new('@abc')
    line.variable.should eq 'abc'
  end

  it 'should report if the A instruction is a variable' do
    line = Assembler::SourceLine.new('@abc')
    line.variable?.should be_true
  end

  it 'should strip white space and trailing comments' do
    line = Assembler::SourceLine.new('     @123  //comment')
    line.value.should eq 123
  end

  it 'should return a destination code' do
    line = Assembler::SourceLine.new('D = A')
    line.destination.should eq 'D'
  end

  it 'should return a computation code' do
    line = Assembler::SourceLine.new('D = A')
    line.computation.should eq 'A'
    line.destination.should eq 'D'
    line.jump.should be_nil
  end

  it 'should return a jump code' do
    line = Assembler::SourceLine.new('D;JEQ')
    line.jump.should eq 'JEQ'
    line.computation.should eq 'D'
    line.destination.should be_nil
  end

  it 'should parse a complex code' do
    line = Assembler::SourceLine.new('AM = D+A ;JEQ')
    line.destination.should eq 'AM'
    line.computation.should eq 'D+A'
    line.jump.should eq 'JEQ'
  end

  it 'should report if the line is a label' do
    line = Assembler::SourceLine.new('  (GOTO)  ')
    line.label?.should be_true
    line.symbol.should eq 'GOTO'
  end
end
