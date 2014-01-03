# Encoding: utf-8

require 'spec_helper'
require 'assembler/instruction/label'
require 'unit/lib/assembler/instruction/shared_examples'

describe Assembler::Instruction::Label do

  let(:instruction) { Assembler::Instruction::Label.new('GOTO') }

  it_behaves_like 'an instruction'

  it 'should be instantiated with the symbol' do
    instruction.symbol.should eq 'GOTO'
  end

  it 'should add an entry to the symbol table' do
    mock_symbol_table = double 'Assembler::SymbolTable'
    mock_symbol_table.should_receive(:add_entry).with('GOTO', 10)
    instruction.prepare_line(mock_symbol_table, 10).should eq 10
  end

end
