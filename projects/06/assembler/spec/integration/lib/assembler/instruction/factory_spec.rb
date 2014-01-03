# Encoding: utf-8

require 'spec_helper'
require 'assembler/instruction/factory'
require 'assembler/instruction/label'
require 'assembler/instruction/address'
require 'assembler/instruction/computation'

describe Assembler::Instruction::Factory do

  it 'should return a valid label instruction' do
    i = build('  (GOTO)   //goto statement')
    i.should be_an_instance_of Assembler::Instruction::Label
    i.symbol.should eq 'GOTO'
  end

  it 'should return a valid address instruction' do
    i = build('  @var   //address statement')
    i.should be_an_instance_of Assembler::Instruction::Address
    i.value.should eq 'var'
  end

  it 'should return a valid address instruction' do
    i = build('  @123   //address statement')
    i.should be_an_instance_of Assembler::Instruction::Address
    i.value.should eq 123
  end

  it 'should return a valid computation instruction' do
    i = build('  D=M              // D = first number')
    i.should be_an_instance_of Assembler::Instruction::Computation
    i.jump.should be_nil
    i.destination.should eq 'D'
    i.computation.should eq 'M'
  end

  it 'should return a valid jump instruction' do
    i = build('  D;JGT             //jump')
    i.should be_an_instance_of Assembler::Instruction::Computation
    i.jump.should eq 'JGT'
    i.computation.should eq 'D'
    i.destination.should be_nil
  end

  def build(line)
    Assembler::Instruction::Factory.build_instruction(line)
  end
end
