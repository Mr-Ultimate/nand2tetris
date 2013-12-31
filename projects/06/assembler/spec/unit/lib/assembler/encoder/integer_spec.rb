# Encoding: utf-8

require 'spec_helper'
require 'assembler/encoder/integer'

describe Assembler::Encoder::Integer do
  it 'should be initialized with an integer' do
    encoder = Assembler::Encoder::Integer.new(100)
    encoder.encode.should eq '0000000001100100'
  end
end
