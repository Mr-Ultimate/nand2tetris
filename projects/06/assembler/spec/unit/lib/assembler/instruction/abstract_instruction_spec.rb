# Encoding: utf-8

require 'spec_helper'
require 'assembler/instruction/abstract_instruction'
require 'unit/lib/assembler/instruction/shared_examples'

describe Assembler::Instruction::AbstractInstruction do

  let(:instruction) { Assembler::Instruction::AbstractInstruction.new }
  let(:symbol_table_stub) { double 'Assembler::SymbolTable' }

  it_behaves_like 'an instruction' do
    let(:instruction) { Assembler::Instruction::AbstractInstruction.new }
  end

  it 'should increment the line number by default' do
    instruction.prepare_line(symbol_table_stub, 10).should eq 11
  end

  it 'should return nil for encode by default' do
    instruction.encode(symbol_table_stub).should be_nil
  end

end


