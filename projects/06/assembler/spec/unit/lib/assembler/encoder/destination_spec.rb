# Encoding: utf-8

require 'spec_helper'
require 'assembler/encoder/destination'

describe Assembler::Encoder::Destination do

  def new_encoder(code)
    Assembler::Encoder::Destination.new(code)
  end

  it 'should be initialized with a three character jump code' do
    new_encoder('A').code.should eq 'A'
  end

  it 'should return a 3 bit encoding of a valid jump code' do
    new_encoder('M').encode.should eq '001'
    new_encoder('D').encode.should eq '010'
    new_encoder('MD').encode.should eq '011'
    new_encoder('A').encode.should eq '100'
    new_encoder('AM').encode.should eq '101'
    new_encoder('AD').encode.should eq '110'
    new_encoder('AMD').encode.should eq '111'
  end

  it 'should encode zeros for a nil code' do
    new_encoder(nil).encode.should eq '000'
  end

  it 'should raise a syntax error if code is unknown' do
    expect do
      new_encoder('BAD').encode
    end.to raise_error SyntaxError, '"BAD" is not a valid destination code!'
  end

  it 'should raise a syntax error if the code is not in uppercase' do
    expect do
      new_encoder('bad').encode
    end.to raise_error SyntaxError, 'Assembly mnemonics must be written in uppercase, "bad" is not!'
  end
end
