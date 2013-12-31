# Encoding: utf-8

require 'spec_helper'
require 'assembler/encoder/computation'

describe Assembler::Encoder::Computation do
  def new_encoder(code)
    Assembler::Encoder::Computation.new(code)
  end

  it 'should be initialized with a computation code' do
    new_encoder('A+M').code.should eq 'A+M'
  end

  it 'should raise a syntax error if the code is not in uppercase' do
    expect do
      new_encoder('a+m').encode
    end.to raise_error SyntaxError, 'Assembly mnemonics must be written in uppercase, "a+m" is not!'
  end

  it 'should raise a syntax error if code is unknown' do
    expect do
      new_encoder('BAD').encode
    end.to raise_error SyntaxError, '"BAD" is not a valid computation code!'
  end

  it 'should return a 7 bit encoding of a valid computation code' do
    {
     '0' => '0101010',
     '1' => '0111111',
     '-1' => '0111010',
     'D' => '0001100',
     'A' => '0110000',
     '!D' => '0001101',
     '!A' => '0110001',
     '-D' => '0001111',
     '-A' => '0110011',
     'D+1' => '0011111',
     'A+1' => '0110111',
     'D-1' => '0001110',
     'A-1' => '0110010',
     'D+A' => '0000010',
     'D-A' => '0010011',
     'A-D' => '0000111',
     'D&A' => '0000000',
     'D|A' => '0010101',
     'M' => '1110000',
     '!M' => '1110001',
     '-M' => '1110011',
     'M+1' => '1110111',
     'M-1' => '1110010',
     'D+M' => '1000010',
     'D-M' => '1010011',
     'M-D' => '1000111',
     'D&M' => '1000000',
     'D|M' => '1010101'
    }.each do |code, encoded|
      new_encoder(code).encode.should eq encoded
    end
  end

  it 'should support reverse order of + & and | operations' do
    {
     '1+D' => '0011111',
     '1+A' => '0110111',
     'A+D' => '0000010',
     'A&D' => '0000000',
     'A|D' => '0010101',
     '1+M' => '1110111',
     'M+D' => '1000010',
     'M&D' => '1000000',
     'M|D' => '1010101'
    }.each do |code, encoded|
      new_encoder(code).encode.should eq encoded
    end
  end
end
