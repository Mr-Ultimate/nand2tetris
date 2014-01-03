# Encoding: utf-8

require 'spec_helper'
require 'assembler/instruction/factory'

describe Assembler::Instruction::Factory do
  it 'should implement build_instruction' do
    Assembler::Instruction::Factory.should respond_to :build_instruction
  end

  it 'should return nil for an invalid line' do
    build('').should be_nil
    build('           ').should be_nil
    build("   \n     ").should be_nil
    build(' // arbitrary comments  ').should be_nil
  end

  def build(line)
    Assembler::Instruction::Factory.build_instruction(line)
  end
end
