# Encoding: utf-8

require 'spec_helper'
require 'assembler/source_line_encoder'
require 'assembler/source_line'

describe Assembler::SourceLineEncoder do

  it 'should encode an A instruction correctly' do
    source_line = Assembler::SourceLine.new('@100')
    encoder = Assembler::SourceLineEncoder.new(source_line)
    encoder.encode.should eq '0000000001100100'
  end

  it 'should encode a C instruction correctly' do
    source_line = Assembler::SourceLine.new('D=A')
    encoder = Assembler::SourceLineEncoder.new(source_line)
    encoder.encode.should eq '1110110000010000'
  end

  it 'should encode a backwards C instruction correctly' do
    source_line = Assembler::SourceLine.new('D=A+D')
    encoder = Assembler::SourceLineEncoder.new(source_line)
    encoder.encode.should eq '1110000010010000'
  end

  it 'should encode a jump C instruction correctly' do
    source_line = Assembler::SourceLine.new('D;JGT')
    encoder = Assembler::SourceLineEncoder.new(source_line)
    encoder.encode.should eq '1110001100000001'
  end

end
