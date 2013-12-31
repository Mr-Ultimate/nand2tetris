# Encoding: utf-8

require 'spec_helper'
require 'assembler/encoder/jump'

describe Assembler::Encoder::Jump do

  def new_encoder(code)
    Assembler::Encoder::Jump.new(code)
  end

  it 'should be initialized with a three character jump code' do
    new_encoder('JEQ').code.should eq 'JEQ'
  end

  it 'should return a 3 bit encoding of a valid jump code' do
    new_encoder('JGT').encode.should eq '001'
    new_encoder('JEQ').encode.should eq '010'
    new_encoder('JGE').encode.should eq '011'
    new_encoder('JLT').encode.should eq '100'
    new_encoder('JNE').encode.should eq '101'
    new_encoder('JLE').encode.should eq '110'
    new_encoder('JMP').encode.should eq '111'
  end

  it 'should encode zeros for a nil code' do
    new_encoder(nil).encode.should eq '000'
  end

  it 'should raise a syntax error if code is unknown' do
    expect do
      new_encoder('BAD').encode
    end.to raise_error SyntaxError, '"BAD" is not a valid jump code!'
  end

  it 'should raise a syntax error if the code is not in uppercase' do
    expect do
      new_encoder('bad').encode
    end.to raise_error SyntaxError, 'Assembly mnemonics must be written in uppercase, "bad" is not!'
  end
end
