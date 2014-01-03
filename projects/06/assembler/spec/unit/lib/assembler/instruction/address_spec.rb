# Encoding: utf-8

require 'spec_helper'
require 'assembler/instruction/address'
require 'unit/lib/assembler/instruction/shared_examples'

describe Assembler::Instruction::Address do

  let(:instruction) { Assembler::Instruction::Address.new(100) }
  let(:symbol_table_stub) { double 'Assembler::SymbolTable' }

  it_behaves_like 'an instruction'

  it 'should be instantiated with a value' do
    instruction.value.should eq 100
  end

  it 'should encode a number to 16 bit' do
    instruction.encode(symbol_table_stub).should eq '0000000001100100'
  end

  it 'for a variable it should return the encoded value from the symbol table' do
    mock_symbol_table = double 'Assembler::SymbolTable'
    mock_symbol_table.should_receive(:contains?).with('GOTO').and_return(true)
    mock_symbol_table.should_receive(:address_for).with('GOTO').and_return(100)
    i = Assembler::Instruction::Address.new('GOTO')
    i.encode(mock_symbol_table).should eq '0000000001100100'
  end

  it 'should save a reference to the symbol table and return that encoded reference' do
    mock_symbol_table = double 'Assembler::SymbolTable'
    mock_symbol_table.should_receive(:contains?).with('GOTO').and_return(false)
    mock_symbol_table.should_receive(:add_reference).with('GOTO').and_return(100)
    i = Assembler::Instruction::Address.new('GOTO')
    i.encode(mock_symbol_table).should eq '0000000001100100'
  end
end
